import 'package:dio/dio.dart' as dio;
import 'package:notespedia/src/features/subscription/subscription_controller.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';

import '../../../repositories/user_preferences.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../detailed/controller/transaction_controller.dart';
import 'controller/course_controller.dart';
import 'fragment/home_sliver_appbar.dart';
import 'fragment/listview_circular_stories.dart';
import 'fragment/listview_fresh_release_books.dart';
import 'fragment/listview_top_reads.dart';
import 'fragment/multi_section_categories.dart';
import 'fragment/staff_slider_and_indicator.dart';

class FirstHomePage extends StatelessWidget {
  FirstHomePage({super.key});

  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final homeScrollController = ScrollController();

  final auController = Get.find<AuthenticationController>();
  final hoController = Get.put(HomeScreenController());
  final seController = Get.find<SearchScreenController>();
  @override
  Widget build(BuildContext context) {
    final Rx<int> selectedIndex = 0.obs;
    Get.put(SearchScreenController());
    Get.put(CourseSelectionController());
    Get.put(FreshReleaseController());
    Get.put(StaffPublisherController());
    Get.put(TransactionController());
    Get.put(TopReadsController());
    Get.put(CircularStoryController());
    Get.put(BooksCategoryController());
    Get.put(SubscriptionController());
    Get.put(UserProfileController());
    final UserProfileController userProfileController =
        Get.find<UserProfileController>();
    final TransactionController transactionController =
        Get.find<TransactionController>();
    var userid = UserPreferences.userId;
    userProfileController.fetchUserProfile(userid);
    transactionController.fetchTransactions();
    final CourseController courseController = Get.put(CourseController());
    courseController.fetchCourses();
    final SubscriptionController subscriptionController =
        Get.put(SubscriptionController());
    courseController.fetchCourses();
    subscriptionController.fetchUserSubscription();
    return Scaffold(
      key: homeScaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: MainNavigationDrawer(),
      // floatingActionButtonLocation: ExpandableFab.location,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createBlankDocument();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          AppImages.editIcon,
          color: Colors.black,
          size: 26,
        ),
      ),
      // floatingActionButton: const ExpandableFabFloatingActionButton(),
      extendBody: true,
      body: RefreshIndicator.adaptive(
        edgeOffset: 20,
        displacement: 80,
        onRefresh: () {
          return hoController.refreshData(context);
        },
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          controller: homeScrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            // Appbar Section
            HomeSliverAppBar(
              onPressed: () {
                homeScaffoldKey.currentState?.openDrawer();
              },
            ),

            // Search Section
            const SliverGap(18),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to the search route when the search bar is clicked
                    Get.toNamed(AppRoutes.searchRoute);
                  },
                  child: AbsorbPointer(
                    // Use AbsorbPointer to ignore taps on the child widget
                    child: ReusableSearchBarFormField(
                      searchController: seController.searchTextController,
                      onChanged: (value) {},
                      onEditingComplete: () {
                        // You might leave this empty or remove it if tapping navigates away
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Story Section
            const SliverGap(16),
            SliverToBoxAdapter(child: ListviewCircularStories()),

            // Fresh Release Section
            const SliverGap(8),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 3.0),
                child: ReusableTitleAndIconButton(
                  title: "Fresh Release",
                  onPressed: () {
                    Get.toNamed(AppRoutes.freshReleasedBooksRoute);
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: ListviewFreshReleaseBooks()),

            // Staff Section
            const SliverGap(16),
            SliverToBoxAdapter(child: StaffSliderAndIndicator()),

            // Top Reads Section
            const SliverGap(14),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: ReusableTitleWithoutButton(title: "Top Reads"),
              ),
            ),
            SliverToBoxAdapter(child: ListviewTopReads()),

            // Categories Section
            const SliverGap(14),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: ReusableTitleWithoutButton(title: "Categories"),
              ),
            ),
            SliverToBoxAdapter(child: MultiSectionCategories()),

            // Continue Reading Section
            // Obx(() {
            //   return SliverVisibility(
            //     visible: auController.isLoggedIn.isTrue ? true : false,
            //     sliver: const SliverGap(10),
            //   );
            // }),
            // Obx(() {
            //   return SliverVisibility(
            //     visible: auController.isLoggedIn.isTrue ? true : false,
            //     sliver: SliverPadding(
            //       padding: const EdgeInsets.only(left: 16.0, right: 3.0),
            //       sliver: SliverToBoxAdapter(
            //         child: ReusableTitleAndIconButton(
            //           title: "Continue Reading",
            //           onPressed: () {
            //             Get.toNamed("/continueReadingBooks");
            //           },
            //         ),
            //       ),
            //     ),
            //   );
            // }),
            // Obx(() {
            //   return SliverVisibility(
            //     visible: auController.isLoggedIn.isTrue ? true : false,
            //     sliver: const SliverToBoxAdapter(
            //       child: ListviewContinueReadingBooks(),
            //     ),
            //   );
            // }),

            // Suggested friends Section
            // Obx(() {
            //   return SliverVisibility(
            //     visible: auController.isLoggedIn.isTrue ? true : false,
            //     sliver: const SliverGap(10),
            //   );
            // }),
            // Obx(() {
            //   return SliverVisibility(
            //     visible: auController.isLoggedIn.isTrue ? true : false,
            //     sliver: const SliverPadding(
            //       padding: EdgeInsets.only(left: 16.0, right: 3.0),
            //       sliver: SliverToBoxAdapter(
            //         child:
            //             ReusableTitleWithoutButton(title: "Suggested friends"),
            //       ),
            //     ),
            //   );
            // }),
            // Obx(() {
            //   return SliverVisibility(
            //     visible: auController.isLoggedIn.isTrue ? true : false,
            //     sliver:
            //         const SliverToBoxAdapter(child: ListviewSuggestedFriends()),
            //   );
            // }),

            // Explorer Item Section
            // const SliverGap(10),
            // const SliverPadding(
            //   padding: EdgeInsets.only(left: 16.0, right: 3.0),
            //   sliver: SliverToBoxAdapter(
            //     child: ReusableTitleWithoutButton(title: "Explore"),
            //   ),
            // ),
            // SliverGridHomeExplore()

            // //
            // const SliverGap(24),
          ],
        ),
      ),
    );
  }

  Widget buildCustomNavigationBar(BuildContext context, Rx<int> selectedIndex) {
    final authController = Get.find<AuthenticationController>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Add this line
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.brightGreen,
      unselectedItemColor: AppColors.greyBrightIconColor,
      currentIndex: selectedIndex.value,
      onTap: (index) {
        if (index == 2 && authController.isLoggedIn.isFalse) {
          HelperFunctions.showTopSnackBar(
            context: context,
            title: "Status Message",
            message: "Please Login",
          );
          Get.toNamed(AppRoutes.signInMobileRoute);
        } else {
          selectedIndex.value = index;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(AppImages.homeIcon, size: 26),
          label: AppTexts.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(AppImages.shelfIcon, size: 26),
          label: AppTexts.shelf,
        ),
        BottomNavigationBarItem(
          icon: Icon(AppImages.exploreIcon, size: 26),
          label: AppTexts.explore,
        ),
        BottomNavigationBarItem(
          icon: Icon(AppImages.accountIcon, size: 26),
          label: AppTexts.account,
        ),
      ],
    );
  }

  void createBlankDocument() async {
    List<NewPage> pages = [
      NewPage.fromPattern(PagePattern.blank, pageSize: PageSize.a5),
    ];

    final tempDir = await Pspdfkit.getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/blankPdf.pdf';

    var filePath =
        await PspdfkitProcessor.instance.generatePdf(pages, tempDocumentPath);

    await Pspdfkit.present(filePath!);

    Pspdfkit.pdfViewControllerWillDismiss = () => saveNote(filePath);
  }

  Future<void> saveNote(String filePath) async {
    String apiUrl = '${ApiConstants.baseUrl}shelf/notes/';

    dio.Dio dioInstance = dio.Dio();
    String fileName = filePath.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      "user_id": UserPreferences.userId,
      "file": await dio.MultipartFile.fromFile(filePath, filename: fileName),
    });
    try {
      var response = await dioInstance.post(apiUrl, data: formData);
      return response.data['id'];
    } catch (error) {
      print(error);
    }
  }
}
