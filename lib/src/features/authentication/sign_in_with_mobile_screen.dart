import 'package:notespedia/src/features/authentication/sign_up_with_mobile_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../navigation/home_screen.dart';
import '../navigation/navigationController.dart';
import 'fragment/auth_bottom_section.dart';
import 'fragment/auth_title.dart';
import 'fragment/image_section.dart';
import 'fragment/or_section.dart';
import 'fragment/phone_number_section.dart';
import 'fragment/with_apple_button.dart';
import 'fragment/with_google_button.dart';

class SignInWIthMobileScreen extends StatefulWidget {
  const SignInWIthMobileScreen({super.key});

  @override
  State<SignInWIthMobileScreen> createState() => _SignInWIthMobileScreenState();
}

class _SignInWIthMobileScreenState extends State<SignInWIthMobileScreen> {
  //
  final mobileNumberController = TextEditingController();
  final authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    //final shouldReturnToHome = Get.arguments?["returnToHome"] ?? false;
    Get.put(CourseSelectionController());
    Get.put(FreshReleaseController());
    Get.put(StaffPublisherController());
    Get.put(TopReadsController());
    Get.put(CircularStoryController());
    Get.put(BooksCategoryController());
    return WillPopScope(
        onWillPop: () async {
          Get.back(); // Default back action

          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageSection(),

                //
                const Gap(50),
                const AuthTitle(title: "Welcome back"),

                //
                const Gap(32),
                PhoneNumberSection(
                  textController: mobileNumberController,
                  onTap: () {
                    authController.mobileLogin(
                      ctx: context,
                      mobileNo: mobileNumberController.text,
                    );
                  },
                ),

                const Gap(24),
                const OrSection(),

                // Apple Section
                const Gap(32),
                // WithAppleButton(
                //   text: "Sign In With Apple",
                //   onPressed: () {},
                // ),
                //
                // // Google Section
                // const Gap(8),
                // WithGoogleButton(
                //   text: "Sign In With Google",
                //   onPressed: () {},
                // ),

                //
                const Gap(24),
                OrNavigation(
                  text: "Sign in with email",
                  onTap: () {
                    Get.toNamed(AppRoutes.signInEmailRoute);
                  },
                ),

                //
                const Gap(60),
                AuthBottomSection(
                  text: "New to Notespaedia?",
                  navText: "Sign Up",
                  onTap: () {
                    Get.toNamed(AppRoutes.signUpMobileRoute);
                  },
                ),
              ],
            ),
          ),
        ));
  }

  // void navigateBackToHome() {
  //   Get.find<NavigationController>().changeIndex(0); // Set selectedIndex to 3
  //   Get.to(() => HomeScreen());
  // }
}
