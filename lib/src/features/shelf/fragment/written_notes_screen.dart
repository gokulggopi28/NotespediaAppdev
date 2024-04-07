import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:notespedia/models/local/local_written_notes_model.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/features/home/controller/downloadandopenpdf.dart';
import 'package:notespedia/src/features/shelf/written_notes_controller.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';

class WrittenNotesScreen extends StatefulWidget {
  const WrittenNotesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WrittenNotesScreenState();
}

class _WrittenNotesScreenState extends State<WrittenNotesScreen> {


  late Future<List<LocalWrittenNotesModel>> allNotes;

  @override
  void initState() {
    allNotes = fetchWrittenNotes();
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
      body: FutureBuilder<List<LocalWrittenNotesModel>>(
        future: allNotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          List<LocalWrittenNotesModel>? writtenNotes = snapshot.data;

          return (writtenNotes != null) ? CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: ScrollController(),
            physics: const ClampingScrollPhysics(),
            slivers: [
              const ReusableBackSliverAppbar(titleText: "Written Notes"),

              //
              const SliverGap(18),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverAnimatedGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                              writtenNotes[index].bookCoverImg,
                              onTap: () {
                                String? url = writtenNotes[index].fileURL;
                                int bookId = writtenNotes[index].id;
                                if (url != null) {
                                  openPDFFromRemoteURL(url, bookId);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  initialItemCount: writtenNotes.length,
                ),
              ),

              //
              const SliverGap(42),
            ],
          ):
          ErrorWidget('Something went wrong');
        },
      ),
    );
  }



  Future<void> openPDFFromRemoteURL(String url, int bookId) async {
    // The URL of the PDF you want to download.

    // Fetch the PDF from the URL.
    //final pdfResponse = await http.get(pdfUrl);

    final pdfResponse = await dio.Dio().get(
        url,
        //Received data with List<int>
        options: dio.Options(
          responseType: dio.ResponseType.bytes,
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

    Pspdfkit.pdfViewControllerWillDismiss = () => saveNote(bookId, pdfFile.path);

  }

  Future<void> saveNote(int bookId, String filePath) async {
    String apiUrl = '${ApiConstants.baseUrl}shelf/notes/$bookId/';

    dio.Dio dioInstance = dio.Dio();
    String fileName = filePath.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      "user_id": UserPreferences.userId,
      "file":
      await dio.MultipartFile.fromFile(filePath, filename:fileName),
    });
    try {
      var response = await dioInstance.put(apiUrl, data: formData);
      setState(() {
        allNotes = fetchWrittenNotes();
      });
      return response.data['id'];
    } catch (error) {
      print(error);
    }
  }
}
