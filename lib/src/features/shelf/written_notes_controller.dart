import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import '../../../../models/local/local_written_notes_model.dart';

Future<List<LocalWrittenNotesModel>> fetchWrittenNotes() async {
  var userId = UserPreferences.userId;
  var response1 = await Dio().request(
    'https://notespaedia.deienami.com/api/shelf/notes/?user_id=$userId',
    options: Options(
      method: 'GET',
    ),
  );

  List<dynamic> parsedJsonList = response1.data;

  List<LocalWrittenNotesModel> myModels = parsedJsonList.map((json) => LocalWrittenNotesModel.fromJson(json)).toList();

  return myModels;
}