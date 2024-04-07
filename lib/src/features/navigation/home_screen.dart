import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/features/account/fourth_account_screen.dart';
import 'package:notespedia/src/features/explorer/third_explorer_page.dart';
import 'package:notespedia/src/features/home/first_home_page.dart';
import 'package:notespedia/src/features/shelf/second_shelf_page.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../authentication/sign_in_with_mobile_screen.dart';
import '../home/controller/save_later_controller.dart';
import '../subscription/subscription_controller.dart';
import 'navigationController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final NavigationController navigationController =
      Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    Get.put(CartAndOrderController());
    Get.put(SaveForLaterBooksController());
    Get.put(SubscriptionController());
    Get.put(CourseSelectionController());
    Get.put(SearchScreenController());
    Get.put(UserProfileController());
    final UserProfileController userProfileController =
        Get.find<UserProfileController>();
    var userid = UserPreferences.userId;

    userProfileController.fetchUserProfile(userid);
    final SubscriptionController subscriptionController =
        Get.find<SubscriptionController>();
    subscriptionController.fetchUserSubscription();
    final SaveForLaterBooksController saveforlaterController =
        Get.find<SaveForLaterBooksController>();
    saveforlaterController.fetchSaveForLaterBooks();
    final List<Widget> screens = [
      FirstHomePage(),
      SecondShelfPage(),
      ThirdExplorerPage(),
      FourthAccountPage(),
    ];

    return Scaffold(
      body: Obx(() => screens[navigationController.selectedIndex.value]),
      bottomNavigationBar: buildCustomNavigationBar(context),
    );
  }

  Widget buildCustomNavigationBar(BuildContext context) {
    final authController = Get.find<AuthenticationController>();
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.brightGreen,
          unselectedItemColor: AppColors.greyBrightIconColor,
          currentIndex: navigationController.selectedIndex.value,
          onTap: (index) {
            if (index == 2) {
              navigationController.changeIndex(index);
            }
            if (index == 1 && !authController.isLoggedIn.value) {
              // Adjust logic as needed
              HelperFunctions.showTopSnackBar(
                context: context,
                title: "Status Message",
                message: "Please Login",
              );
              Get.to(() => SignInWIthMobileScreen(),
                  arguments: {"returnToHome": true});
            } else {
              navigationController.changeIndex(index);
            }
            if (index == 3 && !authController.isLoggedIn.value) {
              // Adjust logic as needed
              HelperFunctions.showTopSnackBar(
                context: context,
                title: "Status Message",
                message: "Please Login",
              );
              Get.to(() => SignInWIthMobileScreen(),
                  arguments: {"returnToHome": true});
            } else {
              navigationController.changeIndex(index);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Shelf'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account'),
          ],
        ));
  }
}
