class AllBooks {
  AllBooks({
    required this.booksList,
});
  final List<LocalContinueReadingModel> booksList;

  factory AllBooks.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LocalContinueReadingModel> booksList =
    list.map((i) => LocalContinueReadingModel.fromJson(i)).toList();

    return AllBooks(
      booksList: booksList,
    );
  }
}

class LocalContinueReadingModel {
  LocalContinueReadingModel({
    required this.id,
    required this.bookTitle,
    required this.bookDescription,
    required this.bookCoverImg,
    required this.chaptersTotalCount,
    required this.chaptersReadedCount,
    required this.newlyChaptersAddedCount,
    required this.fileURL,
    required this.bookId,
  });

  final int id;
  final int bookId;
  final String bookTitle;
  final String bookDescription;
  final String bookCoverImg;
  final dynamic chaptersTotalCount;
  final dynamic chaptersReadedCount;
  final dynamic newlyChaptersAddedCount;
  final String? fileURL;

  factory LocalContinueReadingModel.fromJson(Map<String, dynamic> json) {
    return LocalContinueReadingModel(
      id: json['id'], // Correctly parsing 'id' from JSON
      bookTitle: json['name'],
      bookCoverImg: json['cover_image'],
      chaptersTotalCount: json['chapters'],
      chaptersReadedCount: json['read_chapters'],
      bookDescription: json['name'],
      newlyChaptersAddedCount: json['new_chapters'],
      fileURL: json['file_url'],
      bookId: json['book_id'],
    );
  }

}


List<LocalContinueReadingModel> localContinueReadingList = [
  LocalContinueReadingModel(
    id: 1,
    bookTitle: 'Whispers of the Forgotten',
    bookDescription: 'Description of book 1',
    bookCoverImg:
          "https://s26162.pcdn.co/wp-content/uploads/2019/01/A1ydJm-AvL.jpg",
    chaptersTotalCount: 33,
    chaptersReadedCount: 15,
    newlyChaptersAddedCount: 2,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 2,
    bookTitle: 'Ephemeral Echoes',
    bookDescription: 'Description of book 2',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/812ekc2EmWL.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 3,
    bookTitle: 'The Enigmatic Prism',
    bookDescription: 'Description of book 3',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/9781566895309_FC_1024x1024.jpg",
    chaptersTotalCount: 33,
    chaptersReadedCount: 33,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 4,
    bookTitle: 'Shadows in the Starlight',
    bookDescription: 'Description of book 4',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/9781616208882.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 5,
    bookTitle: 'Chronicles of the Celestial Nomad',
    bookDescription: 'Description of book 5',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/ceb5e9fa5fd3e96f18051f1baf16c62b.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 6,
    bookTitle: 'Echoes of the Lost Kingdom',
    bookDescription: 'Description of book 6',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/A1IHoBxfbGL.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,    fileURL: '', bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 7,
    bookTitle: 'The Quantum Paradox',
    bookDescription: 'Description of book 7',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/71OAdjrRd8L.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 8,
    bookTitle: 'Serenade of the Silver Moon',
    bookDescription: 'Description of book 8',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/Dh0N78JWAAItEWY.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 9,
    bookTitle: 'Mysteries Beyond the Horizon',
    bookDescription: 'Description of book 9',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/images.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 10,
    bookTitle: 'The Labyrinth of Dreams',
    bookDescription: 'Description of book 10',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/814UFARObxL.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 11,
    bookTitle: 'Harmony of the Cosmic Spheres',
    bookDescription: 'Description of book 11',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/GSUGM4AYFMI6TCH67H3XUO6LNQ.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
  LocalContinueReadingModel(
    id: 12,
    bookTitle: 'Journey to the Ethereal Realms',
    bookDescription: 'Description of book 12',
    bookCoverImg:
        "https://s26162.pcdn.co/wp-content/uploads/2019/01/the-cold-is-in-her-bones-9781481488440_hr.jpg",
    chaptersTotalCount: 15,
    chaptersReadedCount: 5,
    newlyChaptersAddedCount: 7,
    fileURL: '',
    bookId: 15,
  ),
];
