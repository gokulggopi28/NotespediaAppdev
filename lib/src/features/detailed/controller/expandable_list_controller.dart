import 'package:notespedia/utils/constants/app_export.dart';

class ExpandableListController extends GetxController {
  var isLoggedIn = true.obs;

  var isExpanded = false.obs;
  var selectedTile = RxInt(-1);

  void toggleExpansion() {
    isExpanded.toggle();
  }

  void onTileClicked(int index) {
    if (!isExpanded.value && index >= 3) {
      // Redirect to login or handle accordingly
      // For now, just print a message
      print('Redirect to login');
    } else {
      selectedTile.value = index;
    }
  }
}
