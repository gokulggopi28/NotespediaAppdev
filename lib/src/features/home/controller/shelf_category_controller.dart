import 'package:dio/dio.dart';

import '../../../../models/shelf_category.dart';
import '../../../../repositories/user_preferences.dart';

Future<List<ShelfBook>> fetchShelfBooks() async {
  final userId =
      UserPreferences.userId; // Assuming 'userId' is correctly retrieved here
  final String apiUrl =
      'https://notespaedia.deienami.com/api/shelf/shelf_books?user_id=$userId'; // Ensure the URL is correct and starts with https://

  Dio dio = Dio();
  List<ShelfBook> books = [];

  try {
    final response = await dio.get(apiUrl);
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    if (response.statusCode == 200 && response.data != null) {
      final data = response.data['data'] as List;
      books = data.map((json) => ShelfBook.fromJson(json)).toList();
    } else {
      print('Failed to load shelf books');
    }
  } catch (e) {
    print('Exception: $e');
  }

  return books;
}
