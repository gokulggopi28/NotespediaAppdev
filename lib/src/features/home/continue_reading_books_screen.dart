import 'dart:io';

import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/features/home/controller/downloadandopenpdf.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';
import 'controller/continue_reading_books_controller.dart';

class ContinueReadingBooksScreen extends StatefulWidget {
  const ContinueReadingBooksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ContinueReadingBooksScreenState();
}

class _ContinueReadingBooksScreenState
    extends State<ContinueReadingBooksScreen> {
  late Future<AllBooks> allBooks;

  @override
  void initState() {
    allBooks = fetchReadBooksForContinuing();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<AllBooks>(
        future: allBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          List<LocalContinueReadingModel>? continueReadingList =
              snapshot.data?.booksList;

          return (continueReadingList != null)
              ? CustomScrollView(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    const ReusableBackSliverAppbar(
                        titleText: "Continue Reading"),

                    //
                    const SliverGap(18),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverAnimatedGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 330,
                          maxCrossAxisExtent: 170,
                          crossAxisSpacing: 22,
                          mainAxisSpacing: 22,
                        ),
                        itemBuilder: (context, index, animation) {
                          final Map<int, Widget> statusIndicator = {
                            1: const ReusableCompleteStatusIndicator(),
                            2: const ReusableOngoingStatusIndicator(),
                            3: const ReusableUpdateStatusIndicator(),
                          };

                          return SizedBox(
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BookCard(
                                    imageUrl:
                                        continueReadingList[index].bookCoverImg,
                                    onTap: () {
                                      String? url =
                                          continueReadingList[index].fileURL;
                                      if (url != null) {
                                        int bookId =
                                            continueReadingList[index].bookId;
                                        downloadAndOpenMyPdf(context, url!,
                                            UserPreferences.userId,
                                            bookId: bookId);
                                      }
                                    },
                                  ),
                                ),
                                const Gap(6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: 115,
                                        height: 5,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                          child: LinearProgressIndicator(
                                            value: continueReadingList[index]
                                                    .chaptersReadedCount /
                                                continueReadingList[index]
                                                    .chaptersTotalCount,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(
                                              Color(0xff09cf64),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 6.0),
                                    //   child: ReusableMoreOptionButton(
                                    //     onPressed: () {
                                    //       moreOptionsBottomSheetForContinueReading(
                                    //           context, index);
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                                BookTitle14(
                                  title:
                                      "${continueReadingList[index].chaptersReadedCount}/"
                                      "${continueReadingList[index].chaptersTotalCount}"
                                      " Chapters",
                                  fontSize: 12,
                                ),
                                Row(
                                  children: [
                                    statusIndicator[
                                            localFreshReleaseBooksList[index]
                                                .bookStatusId] ??
                                        const ReusableUpdateStatusIndicator(),
                                    const Gap(6),
                                    Expanded(
                                      child: BookIndicatorText10Widget(
                                        text: localFreshReleaseBooksList[index]
                                            .bookStatus,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        initialItemCount: continueReadingList.length,
                      ),
                    ),

                    //
                    const SliverGap(42),
                  ],
                )
              : ErrorWidget('Something went wrong');
        },
      ),
    );
  }

  Future<void> openPDFFromRemoteURL(String url) async {
    // The URL of the PDF you want to download.
    const pdfUrl =
        'https://pspdfkit.com/downloads/pspdfkit-flutter-quickstart-guide.pdf';

    // Fetch the PDF from the URL.
    //final pdfResponse = await http.get(pdfUrl);

    final pdfResponse = await Dio().get(url,
        //Received data with List<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ));
    // Check the response status code. If it's not `200` (OK), throw an error.
    if (pdfResponse.statusCode != 200) {
      throw Exception('Failed to download PDF');
    }

    Directory tempDir = await getTemporaryDirectory();
    final dirExists = await tempDir.exists();

    if (!dirExists) {
      await tempDir.create();
    }

    String tempPath = tempDir.path;

    // Create a file to store the PDF.
    final pdfFile = File('$tempPath/my-pdf.pdf');

    // Write the PDF data to the file.
    await pdfFile.writeAsBytes(pdfResponse.data);

    // Use the PSPDFKit `PdfViewer` to display the PDF document.
    final pdfDocument = await Pspdfkit.present(pdfFile.path);
  }
}
