class LocalBooksChapterModel {
  LocalBooksChapterModel({
    required this.title,
    required this.heading,
    required this.readCount,
    required this.totalPages,
  });

  final String title;
  final String heading;
  final int readCount;
  final int totalPages;
}

List<LocalBooksChapterModel> localBooksChaptersList = [
  LocalBooksChapterModel(
    title: "Chapter 1",
    heading: "Nervous system",
    readCount: 8,
    totalPages: 25,
  ),
  LocalBooksChapterModel(
    title: "Chapter 2",
    heading: "Nervous system",
    readCount: 20,
    totalPages: 40,
  ),
  LocalBooksChapterModel(
    title: "Chapter 3",
    heading: "Nervous system",
    readCount: 100,
    totalPages: 100,
  ),
  LocalBooksChapterModel(
    title: "Chapter 4",
    heading: "Nervous system",
    readCount: 8,
    totalPages: 25,
  ),
  LocalBooksChapterModel(
    title: "Chapter 5",
    heading: "Nervous system",
    readCount: 20,
    totalPages: 40,
  ),
  LocalBooksChapterModel(
    title: "Chapter 6",
    heading: "Nervous system",
    readCount: 100,
    totalPages: 100,
  ),
];

List<LocalBooksChapterModel> proBookChaptersList = [];
