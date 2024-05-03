import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart' as pointycastle;
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/stream/ctr.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget_controller.dart';

import '../../../../models/local/get_current_reading_page_model.dart';
import '../../../../repositories/user_preferences.dart';
import '../../../../utils/constants/app_export.dart';
import '../../subscription/subscription_controller.dart';
import 'package:encrypt/encrypt.dart' as encrypt;


Future<void> downloadAndOpenMyPdf(
    BuildContext context, String pdfUrl, int userId,
    {int startPage = 1, int bookId = 14}) async {
  Get.put(SubscriptionController());
  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();

  // Use the user's ID to create a user-specific file path
  final String fileName = Uri.parse(pdfUrl).pathSegments.last;
  final Directory dir = await getApplicationDocumentsDirectory();
  final String userSpecificDirPath = '${dir.path}/user_$userId';
  final Directory userSpecificDir = Directory(userSpecificDirPath);

  if (!await userSpecificDir.exists()) {
    await userSpecificDir.create(recursive: true);
  }

  final String filePath = '$userSpecificDirPath/$fileName';
  final File file = File(filePath);

  if (await file.exists()) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Opening PDF from local storage for User ID: $userId")));
    await _openPdf(
        filePath, context, subscriptionController, startPage, bookId);
  } else {
    final Completer<void> completer = Completer<void>();
    final StreamController<double> progressController =
        StreamController<double>.broadcast();

    _showDownloadingDialog(context, progressController.stream);

    final Dio dio = Dio();
    try {
      await dio.download(pdfUrl, filePath,
          onReceiveProgress: (received, total) {
        final progress = (received / total) * 100;
        progressController.add(progress);
        if (progress == 100) {
          completer.complete();
        }
      });
      await encryptFile(filePath, 'NodZUHhAmh3dbxZd4c9u9w==');
      await completer.future;
      Navigator.pop(context); // Close the progress dialog

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("PDF downloaded and opening")));
      await _openPdf(
          filePath, context, subscriptionController, startPage, bookId);
    } catch (e) {
      Navigator.pop(context); // Close the progress dialog in case of an error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to load the PDF: $e")));
    } finally {
      progressController.close();
    }
  }
}

var currentActivePage = 0;
int currentReadingBookId = 15;
var bookChaptersList = <BookChaptersList>[].obs;

void spreadIndexDidChangeHandler(dynamic arguments) {
  currentActivePage = arguments['currentPageIndex'] + 1;
  print(arguments);
}

void pdfViewControllerWillDismissHandler() async {
  var chaptersList = await getChaptersList(currentReadingBookId);
  var readingChapterId =
      findChapterIdFromPageNumber(currentActivePage, chaptersList);
  callReadingPageUpdateAPI(
      currentReadingBookId, currentActivePage, readingChapterId);
}

Future<void> _openPdf(
    String filePath,
    BuildContext context,
    SubscriptionController subscriptionController,
    int startPage,
    int bookId) async {
  var response = await getCurrentReadingPage(bookId);
  var currentPageNumber = (response.pageno ?? 1) - 1;
  print(response);
  var tempPath = await decryptFile(filePath, 'NodZUHhAmh3dbxZd4c9u9w==');
  final Map<String, dynamic> configuration =
      subscriptionController.subscriptionStatus.value == 'subscribed'
          ? {
              "startPage": currentPageNumber,
              "enableAnnotationEditing": true,
              "androidShowThumbnailGridAction": true,
              "androidShowSearchAction": true,
              "androidShowPrintAction": true,
              "androidEnableDocumentEditor": true,
            }
          : {
              "startPage": currentPageNumber,
              "enableAnnotationEditing": false,
              "androidShowThumbnailGridAction": false,
              "androidShowSearchAction": false,
              "androidShowPrintAction": false,
              "androidEnableDocumentEditor": false,
            };

  currentReadingBookId = bookId;
  await Pspdfkit.present(tempPath, configuration: configuration);
  final tempFile = File(tempPath);
  tempFile.delete();

  Pspdfkit.pdfViewControllerWillDismiss =
      () => pdfViewControllerWillDismissHandler();
  // Pspdfkit.spreadIndexDidChange =
  //     (arguments) => spreadIndexDidChangeHandler(arguments);

  /*
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    await Navigator.of(context).push<dynamic>(CupertinoPageRoute<dynamic>(
        builder: (_) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(),
            child: SafeArea(
                bottom: false,
                child: PspdfkitWidget(documentPath: filePath)
            )
        )
    ));
  } else {
    // This example is only supported in iOS at the moment.
    // Support for Android is coming soon.
  }*/
}

Future<void> callReadingPageUpdateAPI(
    int bookId, int page, int chapterId) async {
  try {
    final response = await HttpService.dioPostRequest(
      url: "${ApiConstants.baseUrl}shelf/update_current_reading/",
      data: {
        "book_id": currentReadingBookId,
        "user_id": UserPreferences.userId,
        'page_no': page,
        'chapter_id': chapterId
      },
    );
    if (response.statusCode == 200) {
      print("Book reading updated");
    }
  } catch (error) {
    print(error);
  }
}

Future<GetCurrentReadingPageModel> getCurrentReadingPage(int bookId) async {
  var userId = UserPreferences.userId;
  final queryParameters = {
    'user_id': '$userId',
    'book_id': '$bookId',
  };

  String queryString = queryParameters.entries
      .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
      .join('&');
  ;
  var completeURL =
      '${ApiConstants.baseUrl}shelf/get_current_reading/?$queryString';
  var encodedURL = Uri.encodeFull(completeURL);
  var response = await Dio().get(Uri.encodeFull(encodedURL));
  var data = response.data['data'];
  return GetCurrentReadingPageModel.fromJson(data);
}

Future<List<BookChaptersList>> getChaptersList(int bookId) async {
  var userId = UserPreferences.userId;
  var queryParameters = {'book_id': bookId, 'user_id': userId};
  String queryString = queryParameters.entries
      .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
      .join('&');
  ;
  var completeURL = '${ApiConstants.baseUrl}books/book_chapters/?$queryString';
  var encodedURL = Uri.encodeFull(completeURL);
  try {
    var response = await Dio().get(Uri.encodeFull(encodedURL));

    if (response.statusCode == 200) {
      final jsonData = bookChaptersModelFromJson(json.encode(response.data));
      bookChaptersList.assignAll(jsonData.chaptersData);
      return bookChaptersList.value;
    } else {
      DebugLogger.warning(
          'Failed to fetch book details: ${response.statusCode}');
    }
  } catch (error) {
    DebugLogger.error("Exception: $error");
  }
  return [];
}

int findChapterIdFromPageNumber(
    int pageNo, List<BookChaptersList> chaptersList) {
  try {
    BookChaptersList chapter = chaptersList.firstWhere((chapter) {
      // Multiline condition
      var upperLimit = chapter.endPage;
      var lowerLimit = chapter.startPage;
      List<int> numbers = List.generate(
          upperLimit - lowerLimit + 1, (index) => index + lowerLimit);
      return numbers.contains(pageNo);
    });
    return chapter.id;
  } catch (error) {
    print(error);
    return 0;
  }
}

void _showDownloadingDialog(
    BuildContext context, Stream<double> progressStream) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              StreamBuilder<double>(
                stream: progressStream,
                builder: (context, snapshot) {
                  final progress = snapshot.data ?? 0.0;
                  return Text(
                      "Downloading PDF... ${progress.toStringAsFixed(0)}%");
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Function to encrypt a file
Future<void> encryptFile(String filePath, String key) async {
  final file = File(filePath);

  // Read the file as bytes
  final Uint8List fileBytes = await file.readAsBytes();

  // Generate IV (Initialization Vector)
  final iv = _generateRandomBytes(16); // IV size for AES-CTR is 16 bytes

  // Convert encryption key from string to list of bytes
  final keyBytes = utf8.encode(key);

  // Create AES-CTR encrypter
  final encrypter = CTRStreamCipher(AESFastEngine())
    ..init(true, pointycastle.ParametersWithIV(pointycastle.KeyParameter(keyBytes), iv));

  // Encrypt the file bytes
  final encryptedBytes = encrypter.process(fileBytes);

  // Write encrypted bytes and IV back to the original file, overwriting its content
  final encryptedData = Uint8List.fromList(iv + encryptedBytes);
  await file.writeAsBytes(encryptedData);

  print('File encrypted successfully');
}

// Function to decrypt a file
Future<String> decryptFile(String filePath, String key) async {
  final file = File(filePath);

  // Read the encrypted file as bytes
  final Uint8List encryptedFileBytes = await file.readAsBytes();

  // Extract IV (Initialization Vector) and ciphertext
  final iv = encryptedFileBytes.sublist(0, 16); // IV size for AES-CTR is 16 bytes
  final ciphertext = encryptedFileBytes.sublist(16);

  // Convert encryption key from string to list of bytes
  final keyBytes = utf8.encode(key);

  // Create AES-CTR decrypter
  final decrypter = CTRStreamCipher(AESFastEngine())
    ..init(false, pointycastle.ParametersWithIV(pointycastle.KeyParameter(keyBytes), iv));

  // Decrypt the file bytes
  final decryptedBytes = decrypter.process(ciphertext);

  // Get the temporary directory
  final tempDir = await getTemporaryDirectory();

  // Create a temporary file and write decrypted bytes to it
  final tempFile = File('${tempDir.path}/decrypted_file.pdf');
  await tempFile.writeAsBytes(decryptedBytes);

  print('File decrypted and saved as temporary file');

  return tempFile.path;
}

// Function to generate random bytes
Uint8List _generateRandomBytes(int length) {
  final secureRandom = pointycastle.SecureRandom('Fortuna');
  final seeds = List<int>.generate(32, (index) => index);
  secureRandom.seed(pointycastle.KeyParameter(Uint8List.fromList(seeds)));
  return Uint8List.fromList(secureRandom.nextBytes(length));
}

