import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_export.dart';
import '../../subscription/subscription_controller.dart';

Future<void> downloadAndOpenPdf(BuildContext context, String pdfUrl, int userId,
    {int startPage = 1}) async {
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
    await _openPdf(filePath, context, subscriptionController, startPage);
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

      await completer.future;
      Navigator.pop(context); // Close the progress dialog

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("PDF Opening")));
      await _openPdf(filePath, context, subscriptionController, startPage);
    } catch (e) {
      Navigator.pop(context); // Close the progress dialog in case of an error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unable to open document:PDF URL not available")));
    } finally {
      progressController.close();
    }
  }
}

Future<void> _openPdf(String filePath, BuildContext context,
    SubscriptionController subscriptionController, int startPage) async {
  final Map<String, dynamic> configuration =
      subscriptionController.subscriptionStatus.value == 'subscribed'
          ? {
              "startPage": startPage - 1,
              "enableAnnotationEditing": true,
              "androidShowThumbnailGridAction": true,
              "androidShowSearchAction": true,
              "androidShowPrintAction": true,
              "androidEnableDocumentEditor": true,
            }
          : {
              "startPage": startPage - 1,
              "enableAnnotationEditing": false,
              "androidShowThumbnailGridAction": false,
              "androidShowSearchAction": false,
              "androidShowPrintAction": false,
              "androidEnableDocumentEditor": false,
            };

  await Pspdfkit.present(filePath, configuration: configuration);
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
                  return Text("Opening PDF... ${progress.toStringAsFixed(0)}%");
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class PDFScreen extends StatefulWidget {
  final String filePath;
  final int startPage;

  const PDFScreen({Key? key, required this.filePath, this.startPage = 1})
      : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  void initState() {
    super.initState();
    openPdf();
  }

  Future<void> openPdf() async {
    final Map<String, dynamic> configuration = {
      "startPage": widget.startPage - 1,
      enableAnnotationEditing: false
    };
    await Pspdfkit.present(widget.filePath, configuration: configuration);
    Navigator.of(context)
        .pop(); // Pop immediately after presenting the PDF might not be desired.
  }

  @override
  Widget build(BuildContext context) {
    // This widget layout starts with a loading indicator but doesn't update or remove it.
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: Center(
          child:
              CircularProgressIndicator()), // Consider updating or removing after PDF is shown.
    );
  }
}
