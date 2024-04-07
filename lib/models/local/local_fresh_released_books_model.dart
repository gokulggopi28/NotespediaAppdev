class LocalFreshReleasedBooksModel {
  LocalFreshReleasedBooksModel({
    required this.id,
    required this.bookTitle,
    required this.bookCoverImg,
    required this.bookDescription,
    required this.bookStatusId,
    required this.bookStatus,
    required this.whatsNew,
    required this.tagsInfo,
    required this.readsCount,
    required this.ratingCount,
    required this.chaptersCount,
    required this.pagesCount,
    required this.bookPrice,
    required this.chapterProAdInfo,
    required this.freeChaptersInfo,
    required this.proChaptersInfo,
    required this.booksRelatedToThis,
  });

  final int id;
  final String bookTitle;
  final String bookCoverImg;
  final String bookDescription;
  final int bookStatusId;
  final String bookStatus;
  final String whatsNew;
  final List<String> tagsInfo;
  final double readsCount;
  final double ratingCount;
  final int chaptersCount;
  final int pagesCount;
  final double bookPrice;
  final String chapterProAdInfo;
  final List<Map<String, dynamic>> freeChaptersInfo;
  final List<Map<String, dynamic>> proChaptersInfo;
  final List<Map<String, dynamic>> booksRelatedToThis;

  //
}

const String lorem =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an "
    "unknown printer took a galley of type and scrambled it to make a type specimen book. "
    "It has survived not only five centuries, but also the leap into electronic typesetting, "
    "remaining essentially unchanged. It was popularised in the 1960s with the release of getset "
    "sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like "
    "Aldus PageMaker including versions of Lorem Ipsum.";

final List<LocalFreshReleasedBooksModel> localFreshReleaseBooksList = [
  LocalFreshReleasedBooksModel(
    id: 1,
    bookTitle: "The Great Gatsby",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2023/08/RedwoodCourt_HC_final-768x1152.jpg",
    bookDescription: lorem,
    bookStatusId: 2,
    bookStatus: 'Ongoing',
    whatsNew: '6 New Chapter Added',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 2,
    bookTitle: "To Kill a Mockingbird",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2023/05/9780593537619-768x1144.jpg",
    bookDescription: lorem,
    bookStatusId: 1,
    bookStatus: 'Complete',
    whatsNew: 'Complete',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 3,
    bookTitle: "1984",
    bookCoverImg: "https://images2.penguinrandomhouse.com/cover/9780593241608",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Updates',
    whatsNew: 'New Updates Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.10,
    ratingCount: 3.5,
    chaptersCount: 55,
    pagesCount: 455,
    bookPrice: 55.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 3',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 4,
    bookTitle: "Pride and Prejudice",
    bookCoverImg: "https://images2.penguinrandomhouse.com/cover/9781984820419",
    bookDescription: lorem,
    bookStatusId: 2,
    bookStatus: 'Ongoing',
    whatsNew: '12 New Chapter Added',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 5,
    bookTitle: "The Catcher in the Rye",
    bookCoverImg: "https://images1.penguinrandomhouse.com/cover/9780593081259",
    bookDescription: lorem,
    bookStatusId: 2,
    bookStatus: 'Ongoing',
    whatsNew: '2 New Chapters Added',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 6,
    bookTitle: "The Hobbit",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/71wWFqpQiL.jpg",
    bookDescription: lorem,
    bookStatusId: 2,
    bookStatus: 'Ongoing',
    whatsNew: '2 New Chapters Added',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 7,
    bookTitle: "Moby-Dick",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2023/08/Lessons_for_Survival_FRONT-768x1167.jpg",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Update',
    whatsNew: 'New Update Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 8,
    bookTitle: "The Lord of the Rings",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/81QwY3R3FVL.jpg",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Update',
    whatsNew: 'New Update Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 9,
    bookTitle: "War and Peace",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2023/07/Cover.Ours_-768x1160.jpg",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Update',
    whatsNew: 'New Update Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 10,
    bookTitle: "The Harry Potter Series",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2023/06/Splinters_FINAL-768x1160.jpg",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Update',
    whatsNew: 'New Update Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 11,
    bookTitle: "Brave New World",
    bookCoverImg: "https://images2.penguinrandomhouse.com/cover/9780593310854",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Update',
    whatsNew: 'New Update Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
  LocalFreshReleasedBooksModel(
    id: 12,
    bookTitle: "The Adventures of Sherlock Holmes",
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2023/05/SIFT-FRONT-768x1024.jpg",
    bookDescription: lorem,
    bookStatusId: 3,
    bookStatus: 'New Update',
    whatsNew: 'New Update Available',
    tagsInfo: [
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
      "High-Yield",
    ],
    readsCount: 9.76,
    ratingCount: 4.5,
    chaptersCount: 33,
    pagesCount: 189,
    bookPrice: 480.00,
    chapterProAdInfo: 'Chapter Pro Ad Info 1',
    freeChaptersInfo: [
      {
        'chapter': "Chapter 1",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 2",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    proChaptersInfo: [
      {
        'chapter': "Chapter 3",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
      {
        'chapter': "Chapter 4",
        'chapterTitle': 'Nervous system',
        'totalChapters': 10,
        'totalChaptersDownloadCount': 8,
        'pages': 25,
      },
    ],
    booksRelatedToThis: [
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 1'},
      {'total': 3, 'count': 2, 'pages': 120, 'title': 'Related Book 2'},
    ],
  ),
];
