import 'dart:convert';

import 'package:notespedia/src/features/home/fragment/list_view_downloads.dart';
import 'package:notespedia/src/features/home/fragment/listview_shelf_categories.dart';
import 'package:notespedia/src/widgets/shelf/unsubscibed_shelf.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../home/fragment/listview_save_for_later_books.dart';
import '../subscription/subscription_controller.dart';
import 'fragment/listview_category_books.dart';
import 'fragment/listview_remixes_books.dart';

import 'fragment/listview_written_notes.dart';

class SecondShelfPage extends StatelessWidget {
  SecondShelfPage({super.key});

  final GlobalKey<ScaffoldState> _shelfScaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _shelfScreenScrollController = ScrollController();
  final TextEditingController folderNameController = TextEditingController();
  // Assuming a default constructor or obtained from a service

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionController());
    final SubscriptionController subscriptionController =
        Get.find<SubscriptionController>();
    subscriptionController.fetchUserSubscription();
    DebugLogger.info("Shelf rebuild");
    Get.put(CartAndOrderController());
    Get.put(CircularStoryController());

    return Obx(() {
      if (subscriptionController.subscriptionStatus.value == 'subscribed') {
        return Scaffold(
          key: _shelfScaffoldKey,
          drawer: MainNavigationDrawer(),
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            controller: _shelfScreenScrollController,
            physics: const ClampingScrollPhysics(),
            slivers: [
              // App bar Section
              MainBasicSliverAppbar(
                text: "Shelf",
                onPressed: () {
                  _shelfScaffoldKey.currentState?.openDrawer();
                },
              ),

              // My Notes Section
              const SliverToBoxAdapter(child: ContainerMyNotes()),
              const SliverGap(8),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16.0, right: 3.0),
                sliver: SliverToBoxAdapter(
                  child: ReusableTitleAndIconButton(
                    title: "Library",
                    onPressed: () {
                      // Get.toNamed("/continueReadingBooks");
                    },
                  ),
                ),
              ),
              FutureBuilderSliverList(),
              // Continue Reading Section
              const SliverGap(8),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16.0, right: 3.0),
                sliver: SliverToBoxAdapter(
                  child: ReusableTitleAndIconButton(
                    title: "Continue Reading",
                    onPressed: () {
                      Get.toNamed("/continueReadingBooks");
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: ListviewContinueReadingBooks()),
              const SliverGap(8),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16.0, right: 3.0),
                sliver: SliverToBoxAdapter(
                  child: ReusableTitleAndIconButton(
                    title: "Written Notes",
                    onPressed: () {
                      Get.toNamed("/writtenNotes");
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: ListViewWrittenNotes()),
              const SliverGap(8),
              SliverPadding(
                padding: const EdgeInsets.only(left: 16.0, right: 3.0),
                sliver: SliverToBoxAdapter(
                  child: ReusableTitleAndIconButton(
                    title: "Downloads",
                    onPressed: () {
                      Get.toNamed("/downloads");
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: ListviewDownloads()),
              // Save for later Section
              // const SliverGap(8),
              // SliverPadding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 3.0),
              //   sliver: SliverToBoxAdapter(
              //     child: ReusableTitleAndIconButton(
              //       title: "Saved for later",
              //       onPressed: () {
              //         Get.toNamed("/saveForLater");
              //       },
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(child: ListviewSaveForLaterBooks()),

              // // Categories Section Part 1
              // const SliverGap(8),
              // SliverPadding(
              //   padding: const EdgeInsets.only(left: 16, right: 8),
              //   sliver: SliverToBoxAdapter(
              //     child: ReusableTitleAndTextButton(
              //       title: "Category",
              //       buttonText: "Add New",
              //       onPressed: () {},
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: ListviewSingleSectionCategory()),

              // // Categories Section Part 2
              // const SliverGap(8),
              // const SliverToBoxAdapter(child: ListviewCategoryBooks()),

              // // Remixes Section
              // const SliverGap(8),
              // SliverPadding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 3.0),
              //   sliver: SliverToBoxAdapter(
              //     child: ReusableTitleAndIconButton(
              //       title: "Remixes",
              //       onPressed: () {
              //         Get.toNamed("/remixesBooks");
              //       },
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: ListviewRemixesBooks()),

              // // Notes Section
              // const SliverGap(8),
              // SliverPadding(
              //   padding: const EdgeInsets.only(left: 16.0, right: 3.0),
              //   sliver: SliverToBoxAdapter(
              //     child: ReusableTitleAndIconButton(
              //       title: "Written Notes",
              //       onPressed: () {
              //         Get.toNamed("/writtenNotes");
              //       },
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: ListviewWrittenNotes()),

              // //
              // const SliverGap(24),
            ],
          ),
        );
      } else {
        // This part assumes you have an `UnsubscribedShelf` widget for non-subscribed users
        return UnSubscribedShelf();
      }
    });
  }
}
