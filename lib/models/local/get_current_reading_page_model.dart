class GetCurrentReadingPageModel {
  GetCurrentReadingPageModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.pageno,
  });

  final int? id;
  final int? bookId;
  final int? userId;
  final int? pageno;

  factory GetCurrentReadingPageModel.fromJson(Map<String, dynamic> json) {
    return GetCurrentReadingPageModel(
      id: json['id'], // Correctly parsing 'id' from JSON
      bookId: json['book_id'],
      userId: json['user_id'],
      pageno: json['page_no']
    );
  }

}