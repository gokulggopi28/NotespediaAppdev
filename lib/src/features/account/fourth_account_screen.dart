import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/app_export.dart';
import '../../widgets/profile/user_profile_controller.dart';
import '../detailed/user_post_screen.dart';
import '../home/controller/course_controller.dart';
import '../home/controller/save_later_controller.dart';
import '../home/controller/user_posts_controller.dart';
import '../home/fragment/listview_save_for_later_books.dart';
import '../shelf/save_for_later_books_screen.dart';
import '../subscription/subscription_controller.dart';

class FourthAccountPage extends StatefulWidget {
  FourthAccountPage({Key? key}) : super(key: key);

  @override
  _FourthAccountPageState createState() => _FourthAccountPageState();
}

class _FourthAccountPageState extends State<FourthAccountPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthenticationController authController = Get.put(
      AuthenticationController()); // Assuming you've registered it in your dependencies

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Get.put(UserProfileController());
    Get.put(SaveForLaterBooksController());
    Get.put(SubscriptionController());
    Get.put(UserPostController());
    Get.put(CourseController());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.put(CourseController());
    courseController.fetchCourses();
    final SubscriptionController subscriptionController =
        Get.put(SubscriptionController());
    courseController.fetchCourses();
    subscriptionController.fetchUserSubscription();
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          ProfileSliverAppbar(),
          const SliverGap(32),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: ProfileHeader()),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    icon: _tabController.index == 0
                        ? Icon(Icons.dashboard)
                        : Icon(Icons.dashboard_outlined),
                  ),
                  Tab(
                    icon: _tabController.index == 1
                        ? Icon(Icons.bookmark)
                        : Icon(Icons.bookmark_border),
                  ),
                ],
                onTap: (index) {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
        body: Obx(() => authController.isLoggedIn.value
            ? TabBarView(
                controller: _tabController,
                children: [
                  UserPostScreen(),
                  SaveForLaterBooksScreen(),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please Login to access"),
                    SizedBox(height: 20),
                    ReusableMaterialButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signInMobileRoute);
                      },
                      height: 50,
                      width: 180,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                      ),
                      child: Text(
                        "Sign In",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
