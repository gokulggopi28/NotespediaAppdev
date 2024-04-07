import 'package:get/get.dart';

class FilterController extends GetxController {
  RxSet<String> selectedCategories = <String>{}.obs;
  RxSet<String> selectedAuthors = <String>{}.obs;
  RxSet<String> selectedPublications = <String>{}.obs;
  RxSet<String> selectedSortBy = <String>{}.obs;
  RxSet<String> selectedRatings = <String>{}.obs;
  RxSet<String> selectedFormats = <String>{}.obs;

  // Add any other methods or logic you need for the filter controller
}
