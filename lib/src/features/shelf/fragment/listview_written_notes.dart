import 'package:notespedia/utils/constants/app_export.dart';
import '../../../../models/local/local_written_notes_model.dart';
import '../written_notes_controller.dart';

class ListViewWrittenNotes extends StatefulWidget {
  const ListViewWrittenNotes({super.key});

  @override
  State<ListViewWrittenNotes> createState() => _ListViewWrittenNotesState();
}

class _ListViewWrittenNotesState extends State<ListViewWrittenNotes> {

  late Future<List<LocalWrittenNotesModel>> allNotes;

  @override
  void initState() {
    allNotes = fetchWrittenNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalWrittenNotesModel>>(
        future: allNotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          List<LocalWrittenNotesModel>? writtenNotesList = snapshot.data;
          return SizedBox(
            height: 350,
            child: ListView.separated(
              itemCount: writtenNotesList?.length ?? 0,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              separatorBuilder: (context, index) {
                return const Gap(22);
              },
              itemBuilder: (context, index) {

                return SizedBox(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BookStackCard(
                          widget: Stack(
                            children: [
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: ReusableCachedNetworkImage(
                                    imageUrl:
                                    writtenNotesList?[index].bookCoverImg ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

/*
class ListviewWrittenNotes extends StatefulWidget {
  const ListviewWrittenNotes({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ListviewWrittenNotesState();

}

class _ListviewWrittenNotesState extends State<ListviewContinueReadingBooks> {


  late Future<AllBooks> allNotes;

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
    return FutureBuilder<AllBooks> (
      future: allNotes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        List<LocalContinueReadingModel>? writtenNotes = snapshot.data?.booksList;
        return SizedBox(
          height: 350,
          child: ListView.separated(
            itemCount: writtenNotes?.length ?? 0,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            separatorBuilder: (context, index) {
              return const Gap(22);
            },
            itemBuilder: (context, index) {
              // DebugLogger.info("Continue Reading Visible Index: $index");

              return SizedBox(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BookStackCard(
                        widget: Stack(
                          children: [
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.bookDetailsRoute);
                                },
                                child: ReusableCachedNetworkImage(
                                  imageUrl:
                                  writtenNotes?[index].bookCoverImg ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(6),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
*/