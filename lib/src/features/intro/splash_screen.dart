import 'package:notespedia/utils/constants/app_export.dart';

import '../../../repositories/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  Future<void> navigateUser() async {
    DebugLogger.info(
      "OnboardingVisited: ${UserPreferences.isVisited}"
      "\nLoggedIn: ${UserPreferences.isLoggedIn}"
      "\nAuthToken: ${UserPreferences.authToken}"
      "\nRefreshToken: ${UserPreferences.refreshToken}"
      "\nUserId: ${UserPreferences.userId}"
      "\nSubscriptionStatus: ${UserPreferences.subscriptionStatus}",
    );

    await Future.delayed(const Duration(seconds: 3));

    if (UserPreferences.isLoggedIn == false &&
        // UserPreferences.authToken.isEmpty &&
        UserPreferences.isVisited == false) {
      DebugLogger.info(
          "Case1: isLoggedIn authToken = false, isVisited = false");
      Get.offAndToNamed(AppRoutes.onboardingRoute);
    } else if (UserPreferences.isLoggedIn == false &&
        // UserPreferences.authToken.isEmpty &&
        UserPreferences.isVisited == true) {
      DebugLogger.info("Case2: isLoggedIn authToken = false, isVisited = true");
      Get.offAndToNamed(AppRoutes.homeRoute);
    } else if (UserPreferences.isLoggedIn == true &&
        // UserPreferences.authToken.isNotEmpty &&
        UserPreferences.isVisited == true) {
      DebugLogger.info("Case3: isLoggedIn authToken = true, isVisited = true");
      Get.offAndToNamed(AppRoutes.homeRoute);
    } else {
      DebugLogger.info("Case4: Fail");
      Get.offAndToNamed(AppRoutes.homeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: DeviceHelper.getScreenWidth(context) * .5,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100.withOpacity(.2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AppImages.appLogo,
                semanticLabel: AppTexts.logo,
                alignment: Alignment.center,
                matchTextDirection: true,
                fit: BoxFit.contain,
                cacheWidth: 1024,
                cacheHeight: 1024,
              ),
            ),
            Flexible(
              child: Text(
                AppTexts.appName,
                semanticsLabel: AppTexts.logo,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
