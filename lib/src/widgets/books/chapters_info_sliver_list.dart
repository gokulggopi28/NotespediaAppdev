import 'dart:io';

import 'package:dio/dio.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:http/http.dart' as http;

import '../../../repositories/user_preferences.dart';
import '../../features/detailed/controller/expandable_list_controller.dart';
import '../../features/home/controller/pdf_viewer.dart';
import '../../features/navigation/custom_login_alert.dart';
import '../../features/navigation/custom_subscription_alert.dart';
import '../../features/subscription/subscription_controller.dart';

class ChapterInfoSliverList extends StatefulWidget {
  @override
  _ChapterInfoSliverListState createState() => _ChapterInfoSliverListState();
}

class _ChapterInfoSliverListState extends State<ChapterInfoSliverList> {
  bool isLoading = false;

  final ExpandableListController controller =
      Get.put(ExpandableListController());
  final BooksDetailController bdController = Get.find<BooksDetailController>();
  final AuthenticationController authController =
      Get.find<AuthenticationController>();
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (bdController.isProcessing.isTrue || bdController.hasError.isTrue) {
        return sliverListLoadingShimmer();
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              bool isUserEligibleForInteraction;
              Color chapterColor;
              if (authController.isLoggedIn.value) {
                // For logged-in users, all chapters are eligible for interaction
                // But will show padlock for unsubscribed users
                isUserEligibleForInteraction = true;
                chapterColor = Colors.white; // No greying out
              } else {
                // For non-logged-in users, only first 3 chapters are eligible
                isUserEligibleForInteraction = index < 3;
                chapterColor = isUserEligibleForInteraction
                    ? Colors.white
                    : Colors.grey[200]!;
              }

              return Padding(
                  padding: EdgeInsets.only(
                      bottom: isUserEligibleForInteraction ? 1.5 : 0),
                  child: Material(
                    color: isUserEligibleForInteraction
                        ? Colors.white
                        : Colors.grey[200],
                    child: InkWell(
                      onTap: () async {
                        if (isUserEligibleForInteraction) {
                          String pdfUrl =
                              bdController.bookChaptersList[index].chapterUrl;
                          if (pdfUrl.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              File localPdfFile =
                                  await downloadAndSavePdfFile(pdfUrl);
                              final Map<String, dynamic> configuration =
                                  subscriptionController
                                              .subscriptionStatus.value ==
                                          'subscribed'
                                      ? {
                                          "enableAnnotationEditing": true,
                                          "androidShowThumbnailGridAction":
                                              true,
                                          "androidShowSearchAction": true,
                                          "androidShowPrintAction": true,
                                          "androidEnableDocumentEditor": true,
                                        }
                                      : {
                                          "enableAnnotationEditing": false,
                                          "androidShowThumbnailGridAction":
                                              false,
                                          "androidShowSearchAction": false,
                                          "androidShowPrintAction": false,
                                          "androidEnableDocumentEditor": false,
                                        };

                              await Pspdfkit.present(localPdfFile.path,
                                  configuration: configuration);
                            } catch (e) {
                              print("Error downloading or opening the PDF: $e");
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            HelperFunctions.showTopSnackBar(
                              context: context,
                              title: "Status Message",
                              message: "Sorry,Chapter Not Available",
                            );
                          }
                        } else {
                          if (!authController.isLoggedIn.value) {
                            // Show login dialog for non-logged-in users trying to access locked content
                            showCustomLoginDialog(context);
                          }
                        }
                      },
                      child: Opacity(
                        opacity: isUserEligibleForInteraction ? 1.0 : 0.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Chapter ${bdController.bookChaptersList[index].chapterIndex}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        bdController.bookChaptersList[index]
                                            .chapterName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "${bdController.bookChaptersList[index].readPages}/${bdController.bookChaptersList[index].pages} Pages",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      bdController.bookDetailData[0]
                                                      .hasSoftCopy ==
                                                  1 &&
                                              bdController.bookDetailData[0]
                                                      .softCopyNewPrice ==
                                                  0
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          subscriptionController
                                                      .subscriptionStatus
                                                      .value ==
                                                  'subscribed'
                                              ? Icons.download
                                              : Icons
                                                  .download, // Use padlock icon for non-subscribed users
                                          size: 24,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () async {
                                          if (authController.isLoggedIn.value) {
                                            if (subscriptionController
                                                    .subscriptionStatus.value ==
                                                'subscribed') {
                                              final BooksDetailController
                                                  bdController = Get.find<
                                                      BooksDetailController>();
                                              final Dio dio = Dio();
                                              try {
                                                String pdfUrl = bdController
                                                    .bookDetailData[0].fileurl;
                                                int userId =
                                                    UserPreferences.userId;
                                                int chapterId = bdController
                                                    .bookChaptersList[0]
                                                    .id; // Assuming bookId is accessible like this
                                                int startPage = bdController
                                                    .bookChaptersList[index]
                                                    .startPage;
                                                int bookId = bdController
                                                    .bookDetailData[0].bookId;
                                                final Map<String, dynamic>
                                                    requestData = {
                                                  "user_id": userId,
                                                  "book_id": bookId,
                                                  "chapter_id": chapterId
                                                };

                                                // Printing the data being sent to the API
                                                print(
                                                    "Sending request data: $requestData");

                                                // Making the API call
                                                final response = await dio.post(
                                                  "${ApiConstants.baseUrl}/shelf/download_book_chapter/",
                                                  data: requestData,
                                                );

                                                // Checking and printing the response
                                                if (response.statusCode ==
                                                    200) {
                                                  print(
                                                      "Response Data: ${response.data}"); // Printing the actual response data
                                                  print(
                                                      "Book Chapter download logged successfully."); // This confirms the log was successful
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Download Successfull")));
                                                  if (pdfUrl.isNotEmpty) {
                                                    await downloadAndOpenPdf(
                                                        context, pdfUrl, userId,
                                                        startPage: startPage);
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "${response.data}")));
                                                  print(
                                                      "Failed to log book chapter download. Status Code: ${response.statusCode}, Response: ${response.data}");
                                                }
                                              } on DioError catch (dioError) {
                                                // Here we specifically catch DioError to access the response data
                                                if (dioError.response != null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "${dioError.response?.data}")));
                                                  print(
                                                      "DioError: ${dioError.response?.data}");
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "${dioError.response?.data}")));
                                                  print(
                                                      "DioError without response data: ${dioError.message}");
                                                }
                                              } catch (e) {
                                                print(
                                                    'Error during download log or opening PDF: $e');
                                              }
                                            } else {
                                              // For non-subscribed but logged-in users, show the subscription dialog
                                              showCustomSubscribeDialog(context,
                                                  onCancel: () async {
                                                // The callback is executed after the dialog is dismissed.
                                                // Proceed with the download logic here if needed, or simply notify the user.

                                                // Assuming you decide to allow the download after the dialog for demonstration
                                                final String pdfUrl =
                                                    bdController
                                                        .bookDetailData[0]
                                                        .fileurl;
                                                final int userId =
                                                    UserPreferences.userId;
                                                if (pdfUrl.isNotEmpty) {
                                                  try {
                                                    // Call your method to handle the PDF download
                                                    await downloadAndOpenPdf(
                                                        context, pdfUrl, userId,
                                                        startPage: bdController
                                                            .bookChaptersList[
                                                                index]
                                                            .startPage);
                                                  } catch (e) {
                                                    print(
                                                        "Error during PDF download or open: $e");
                                                  }
                                                } else {
                                                  print(
                                                      "PDF URL is not available or invalid.");
                                                }
                                              });
                                            }
                                          } else {
                                            showCustomLoginDialog(context);
                                          }
                                        }),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ));
            },
            childCount: authController.isLoggedIn.isTrue
                ? bdController.bookChaptersList.length
                : (bdController.bookChaptersList.length < 3
                    ? bdController.bookChaptersList.length
                    : bdController.bookChaptersList.length),
          ),
        );
      }
    });
  }

  Widget sliverListLoadingShimmer() {
    return SliverList.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const Gap(1.5);
      },
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Column(
                    children: [],
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 5,
    );
  }

  Future<File> downloadAndSavePdfFile(String pdfUrl) async {
    var response = await http.get(Uri.parse(pdfUrl));
    var documentDirectory = await getApplicationDocumentsDirectory();
    File file = File('${documentDirectory.path}/downloaded_pdf.pdf');

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Failed to download file');
    }
    return file;
  }
}
