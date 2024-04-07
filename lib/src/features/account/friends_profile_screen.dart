import 'package:notespedia/utils/constants/app_export.dart';

class FriendsProfileScreen extends StatelessWidget {
  FriendsProfileScreen({super.key});

  final ScrollController _userProfileScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: _userProfileScrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          const FriendsProfileSliverAppbar(),

          // Profile Header Section
          const SliverGap(62),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: ProfileHeader()),
          ),

          // Banner Section
          const SliverGap(16),
          const SliverPadding(
            padding: EdgeInsets.only(left: 16.0, right: 3.0),
            sliver: SliverToBoxAdapter(
              child: ReusableTitleWithoutButton(
                title: "Reading Stats",
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverToBoxAdapter(child: BannerSection()),
          ),

          //
          const SliverGap(16),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            sliver: SliverAnimatedGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 160,
                maxCrossAxisExtent: 120,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index, animation) {
                return Container(
                  height: 160,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const ReusableCachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1682687220566-5599dbbebf11?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxzZWFyY2h8OHx8d2FsbHBhcGVyfGVufDB8fDB8fHww',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              initialItemCount: 6,
            ),
          ),

          //
          const SliverGap(24),
        ],
      ),
    );
  }
}
