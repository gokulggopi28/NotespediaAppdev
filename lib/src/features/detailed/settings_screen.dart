import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/src/features/account/fourth_account_screen.dart';
import 'package:notespedia/src/features/detailed/add_address_screen.dart';
import 'package:notespedia/src/features/detailed/address_list_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../navigation/home_screen.dart';
import '../navigation/navigationController.dart';
import 'personal_information_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final UserProfileController userProfileController =
      Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Check if it's possible to pop the current route.
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false; // Prevent the system from popping the route, as we've handled it manually.
          }
          return true; // Allow the system to handle the back button (e.g., exiting the app) if no routes to pop.
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.find<NavigationController>()
                      .changeIndex(3); // Set selectedIndex to 3
                  Get.to(() => HomeScreen()); // Navigate to HomeScreen
                }),
            title: Text("Settings",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Obx(() => Text(
                        "Signed in as ${userProfileController.userProfile.value?.name ?? 'User'}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      )),
                ),
                // settingsImageRow(context),
                // settingsText("Get 1 month free Premium Plan"),
                // settingsText("Refer and Earn"),
                // settingsCategoryTitle("App Settings"),
                // settingsOption("App Notification"),
                // settingsOption("Dark Mode"),
                // Divider(color: Color(0x1A000000)),
                // settingsItem("Personal Information", false,
                //     () => Get.to(() => PersonalInformationScreen())),
                settingsItem("Account", true,
                    () => Get.to(() => PersonalInformationScreen())),
                settingsItem(
                    "Addresses", true, () => Get.to(() => AddressesScreen())),
                logoutButton(context),
              ],
            ),
          ),
        ));
  }

  Widget settingsImageRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/png/settings_1.png'),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/png/settings_2.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget settingsText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
    );
  }

  Widget settingsCategoryTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 16.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0x80000000))),
      ),
    );
  }

  Widget settingsOption(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 8.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
      ),
    );
  }

  Widget settingsItem(String title, bool withArrow, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black)),
      trailing:
          withArrow ? Icon(Icons.chevron_right, color: Colors.black) : null,
      onTap: onTap,
    );
  }

  Widget logoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: OutlinedButton(
        onPressed: () async {
          final AuthenticationController authController =
              Get.find<AuthenticationController>();
          await authController.logoutAction();
          Get.toNamed(
              AppRoutes.signInMobileRoute); // Update with your sign-in route
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.black), // Set border color here
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          // Text color
          primary: Colors.black,
        ),
        child: Text("Logout"),
      ),
    );
  }
}
