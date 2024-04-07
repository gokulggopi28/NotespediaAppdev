import 'package:dio/dio.dart';

import '../../../models/explorer_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<ExplorePost>> fetchPosts() async {
    try {
      final response = await _dio
          .get('https://notespaedia.deienami.com/api/explore/explore_posts/');
      List<dynamic> data = response.data['data'];
      return data.map((e) => ExplorePost.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
