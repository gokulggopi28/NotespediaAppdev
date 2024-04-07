import 'package:notespedia/utils/constants/app_export.dart';

import '../../../models/explorer_model.dart';
import 'explorer_service_class.dart';

class ExploreController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxList<ExplorePost> explorePosts = <ExplorePost>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    final posts = await _apiService.fetchPosts();
    explorePosts.assignAll(posts);
  }
}
