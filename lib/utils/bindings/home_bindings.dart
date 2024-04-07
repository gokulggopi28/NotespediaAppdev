import 'package:notespedia/utils/constants/app_export.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => CartAndOrderController());
    Get.lazyPut(() => CourseSelectionController());
    Get.lazyPut(() => SearchScreenController());
    Get.lazyPut(() => CircularStoryController());
    Get.lazyPut(() => FreshReleaseController());
    Get.lazyPut(() => StaffPublisherController());
    Get.lazyPut(() => TopReadsController());
    Get.lazyPut(() => BooksCategoryController());
    Get.lazyPut(() => ExplorerItemController());
    Get.lazyPut(() => BooksDetailController());
  }
}
