import 'package:notespedia/utils/constants/app_export.dart';

class HomeScreenController extends GetxController {
  //
  final isRefreshing = false.obs;

  final nSController = Get.find<NetworkStateController>();
  final coController = Get.find<CourseSelectionController>();
  final csController = Get.put(CircularStoryController());
  final frController = Get.put(FreshReleaseController());
  final stController = Get.put(StaffPublisherController());
  final trController = Get.put(TopReadsController());
  final bcController = Get.put(BooksCategoryController());
  final exController = Get.put(ExplorerItemController());
  final caocontroller = Get.put(CartAndOrderController());

  Future<void> refreshData(BuildContext context) async {
    if (nSController.isInternetConnected.isTrue) {
      isRefreshing(true);

      try {
        coController.refreshCourses();
        csController.refreshStories();
        frController.refreshFreshReleaseBooks();
        stController.refreshStaffPublishers();
        trController.refreshTopReadBooks();
        bcController.refreshBooksCategory();
        exController.refreshExplorerItems();
      } catch (error) {
        throw Exception(error);
      }

      isRefreshing(false);
    } else {
      HelperFunctions.showSnackBar(
        context: context,
        message: "No Internet Connection",
      );
      return;
    }
  }
}
