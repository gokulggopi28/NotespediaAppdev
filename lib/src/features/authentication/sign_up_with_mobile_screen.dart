import 'package:notespedia/src/features/authentication/sign_in_with_mobile_screen.dart';
import 'package:notespedia/src/features/authentication/sign_up_with_email_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../navigation/home_screen.dart';
import '../navigation/navigationController.dart';
import 'fragment/auth_bottom_section.dart';
import 'fragment/auth_title.dart';
import 'fragment/image_section.dart';
import 'fragment/or_section.dart';
import 'fragment/phone_number_section.dart';
import 'fragment/terms_and_conditions.dart';
import 'fragment/with_apple_button.dart';
import 'fragment/with_google_button.dart';

class SignUpWithMobileScreen extends StatefulWidget {
  const SignUpWithMobileScreen({super.key});

  @override
  State<SignUpWithMobileScreen> createState() => _SignUpWithMobileScreenState();
}

class _SignUpWithMobileScreenState extends State<SignUpWithMobileScreen> {
  //
  final mobileNumberController = TextEditingController();
  final authController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    Get.put(CourseSelectionController());
    Get.put(FreshReleaseController());
    Get.put(StaffPublisherController());
    Get.put(TopReadsController());
    Get.put(CircularStoryController());
    Get.put(BooksCategoryController());
    return WillPopScope(
        onWillPop: () async {
          navigateBackToHome(); // Call your custom back navigation function
          return false; // Prevents the default back navigation (popping)
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                const ImageSection(),

                //
                const Gap(50),
                const AuthTitle(
                  title: "Explore the most fascinating library",
                ),

                //
                const Gap(32),
                PhoneNumberSection(
                  textController: mobileNumberController,
                  onTap: () {
                    authController.mobileRegister(
                      ctx: context,
                      mobileNo: mobileNumberController.text,
                    );
                  },
                ),

                //
                const Gap(24),
                const OrSection(),

                // Apple Section
                const Gap(32),
                WithAppleButton(
                  text: "Sign Up With Apple",
                  onPressed: () {},
                ),

                // Google Section
                const Gap(8),
                WithGoogleButton(
                  text: "Sign Up With Google",
                  onPressed: () {},
                ),

                //
                const Gap(24),
                OrNavigation(
                  text: "Sign up with email",
                  onTap: () {
                    Get.to(() => SignUpWithEmailScreen());
                  },
                ),

                //
                const Gap(26),
                TermsAndCondition(),

                const Gap(45),
                AuthBottomSection(
                  text: "Already have an account?",
                  navText: "Sign in",
                  onTap: () {
                    Get.to(() => SignInWIthMobileScreen());
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void navigateBackToHome() {
    Get.find<NavigationController>()
        .changeIndex(0); // Adjust the selected index
    Get.offAll(() =>
        HomeScreen()); // Use offAll to ensure no back navigation is possible
  }
}

class OrNavigation extends StatelessWidget {
  const OrNavigation({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            'Or ',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF4B4B4B),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
          ),
          AnimatedGestureDetector(
            onTap: onTap,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF0033B7),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
