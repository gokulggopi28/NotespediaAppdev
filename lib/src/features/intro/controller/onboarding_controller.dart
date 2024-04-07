import 'package:notespedia/utils/constants/app_export.dart';

class OnboardingController extends GetxController {
  final pageController = PageController(initialPage: 0);
  var currentPageIndex = 0.obs;

  @override
  void onInit() {
    pageController.addListener(() {
      currentPageIndex.value = pageController.page?.round() ?? 0;
    });
    super.onInit();
  }

  void goToPage(int index) {
    currentPageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    int page = currentPageIndex.value + 1;

    if (page < 3) {
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
