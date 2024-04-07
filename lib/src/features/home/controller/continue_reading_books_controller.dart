import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import '../../../../models/local/local_continue_reading_model.dart';

Future<AllBooks> fetchReadBooksForContinuing() async {
  var userId = UserPreferences.userId;
  final queryParameters = {
    'userId': userId,
    'continue_reading': 1
  };
  var response1 = await Dio().request(
    'https://notespaedia.deienami.com/api/shelf/shelf_books/?user_id=$userId&continue_reading=1',
    options: Options(
      method: 'GET',
    ),
  );
  var data = response1.data['data'];
  return AllBooks.fromJson(response1.data);
}