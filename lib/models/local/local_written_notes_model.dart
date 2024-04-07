class LocalWrittenNotesModel {
  LocalWrittenNotesModel({
    required this.id,
    required this.bookTitle,
    required this.bookCoverImg,
    required this.fileURL,
  });

  final int id;
  final String bookTitle;
  final String bookCoverImg;
  final String? fileURL;

  factory LocalWrittenNotesModel.fromJson(Map<String, dynamic> json) {
    return LocalWrittenNotesModel(
      id: json['id'],
      bookTitle: json['name'],
      bookCoverImg: json['cover_image'],
      fileURL: json['file_url'],
    );
  }
}