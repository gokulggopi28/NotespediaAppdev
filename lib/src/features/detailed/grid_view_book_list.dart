import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/book_grid_view_model.dart';
import '../../../repositories/user_preferences.dart';
import '../home/controller/downloads_controller.dart';

class ResponsiveGrid extends StatefulWidget {
  final int bookId;
  final int userId;

  ResponsiveGrid({Key? key, required this.bookId, required this.userId})
      : super(key: key);

  @override
  _ResponsiveGridState createState() => _ResponsiveGridState();
}

class _ResponsiveGridState extends State<ResponsiveGrid> {
  @override
  void initState() {
    super.initState();
    downloadsController.fetchBookChaptersGridView(widget.bookId);
  }

  final DownloadsController downloadsController =
      Get.find<DownloadsController>();
  @override
  Widget build(BuildContext context) {
    downloadsController.fetchBookChaptersGridView(widget.bookId);

    double screenWidth = MediaQuery.of(context).size.width;
    int columns = screenWidth > 600 ? 4 : 3;

    return Scaffold(
      appBar: AppBar(title: Text("Book Chapters")),
      body: Obx(() {
        if (downloadsController.isProcessing.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else if (downloadsController.hasError.isTrue ||
            downloadsController.bookChapterGridViewModel.value == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          var chapters =
              downloadsController.bookChapterGridViewModel.value?.data ?? [];
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(10.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    childAspectRatio: 115 / 118,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final chapter = chapters[index];
                      return GestureDetector(
                        onTap: () async {
                          if (chapter.newUpdates == 1) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("New Updates Available"),
                                content: Text(
                                    "Would you like to keep changes or discard them?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await downloadsController
                                          .sendChapterUpdateConfirmation(
                                              chapter.bookId, chapter.id, 1);
                                      downloadsController
                                          .fetchBookChaptersGridView(
                                              chapter.bookId);
                                    },
                                    child: Text("Keep Changes"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await downloadsController
                                          .sendChapterUpdateConfirmation(
                                              chapter.bookId, chapter.id, 2);
                                      downloadsController
                                          .fetchBookChaptersGridView(
                                              chapter.bookId);
                                    },
                                    child: Text("Discard Changes"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            await downloadAndOpenPdf(chapter.chapterUrl,
                                chapter.id.toString(), chapters[index]);
                          }
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Chapter ${chapter.chapterIndex}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0x80000000),
                                    ),
                                  ),
                                  if (chapter.isEdited == 1)
                                    GestureDetector(
                                      onTap: () async {
                                        // Show confirmation dialog
                                        final confirmDelete =
                                            await showDialog<bool>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirm Delete'),
                                              content: Text(
                                                  'Are you sure you want to delete this chapter?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text('Yes'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        if (confirmDelete ?? false) {
                                          await downloadsController
                                              .deleteChapter(widget.bookId,
                                                  chapter.id, context);
                                          downloadsController
                                              .fetchBookChaptersGridView(widget
                                                  .bookId); // Refresh the list
                                        }
                                      },
                                      child: Icon(Icons.delete,
                                          size: 16, color: Colors.black),
                                    ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                chapter.chapterName,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: chapter.readCompletionsPercentage /
                                          100,
                                      backgroundColor: Color(0xFFD9D9D9),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFF05CF64)),
                                      minHeight:
                                          4, // Adjust the height to make the progress bar thinner
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "${chapter.readPages}/${chapter.pages}",
                                    style: TextStyle(
                                      fontSize:
                                          12, // Adjust the font size according to your design
                                    ),
                                  ),
                                ],
                              ),
                              if (chapter.newUpdates == 1)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0), // Adjust spacing as needed
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6, // Size of the bullet
                                        height: 6, // Size of the bullet
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "New Updates",
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize:
                                              10, // Your specified font size
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF000000).withOpacity(
                                              0.8), // Adjusted for opacity
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    '${chapter.pages} pages',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  if (chapter.isEdited == 1)
                                    Text(
                                      " | Edited",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF05CF64),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: chapters.length,
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Future<void> downloadAndOpenPdf(
      String url, String fileName, Chapter chapter) async {
    Dio dioInstance = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.pdf');

    String originalChecksum = "";
    late SharedPreferences prefs;

    try {
      _showLoadingDialog(context);
      prefs = await SharedPreferences.getInstance();

      if (!await file.exists()) {
        print('Downloading file: $fileName');
        await dioInstance.download(url, file.path);
        print('File downloaded and saved as: ${file.path}');
        originalChecksum = await calculateChecksum(file);
        await prefs.setString('checksum_$fileName', originalChecksum);
        print('Original checksum stored.');
      } else {
        print('$fileName already exists.');
        originalChecksum = prefs.getString('checksum_$fileName') ?? "";
      }

      await Pspdfkit.present(file.path);
    } catch (e) {
      print('Error downloading or opening file: $e');
    } finally {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }

    // Recalculate checksum after potential modifications
    final currentChecksum = await calculateChecksum(file);
    if (originalChecksum == currentChecksum) {
      print("No"); // No changes detected
    } else {
      print("Yes"); // Changes detected
      await prefs.setString('checksum_$fileName', currentChecksum);
      print('Checksum updated to reflect the current document state.');
      await downloadsController.updateBookDownloadView(file, chapter);
    }
    downloadsController.fetchBookChaptersGridView(widget.bookId);
  }

  Future<String> calculateChecksum(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      print('Error calculating checksum: $e');
      return '';
    }
  }

  void _showLoadingDialog(BuildContext context) {
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
                const SizedBox(width: 20),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }
}
