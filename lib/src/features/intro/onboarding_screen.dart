import 'package:animate_do/animate_do.dart';
import 'package:notespedia/src/features/intro/fragment/page_view_content.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../../../repositories/user_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final obController = Get.put(OnboardingController());
  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PageView(
                    controller: obController.pageController,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      PageViewContent(
                        image: AppTexts.onBoardData[0]['image'],
                        title: AppTexts.onBoardData[0]['title'],
                        description: AppTexts.onBoardData[0]['description'],
                      ),
                      PageViewContent(
                        image: AppTexts.onBoardData[1]['image'],
                        title: AppTexts.onBoardData[1]['title'],
                        description: AppTexts.onBoardData[1]['description'],
                      ),
                      PageViewContent(
                        image: AppTexts.onBoardData[2]['image'],
                        title: AppTexts.onBoardData[2]['title'],
                        description: AppTexts.onBoardData[2]['description'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                      child: ReusableDotPageIndicator(
                        count: 3,
                        controller: obController.pageController,
                        onDotClicked: obController.goToPage,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FadeIn(
                    duration: const Duration(milliseconds: 1200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 58.0,
                      ),
                      child: ReusableMaterialButton(
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        onPressed: () async {
                          await UserPreferences.setIsVisited(true);
                          authController.debugAuthTestFunction();
                          Get.offNamed(AppRoutes.homeRoute);
                          // Get.toNamed(AppRoutes.signInMobileRoute);
                        },
                        child: Text(
                          AppTexts.getStarted,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Gap(DeviceHelper.getBottomNavigationBarHeight() * 1.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
