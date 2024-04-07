import 'package:notespedia/utils/constants/app_export.dart';

class FriendsProfileSliverAppbar extends StatelessWidget {
  const FriendsProfileSliverAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      floating: true,
      snap: true,
      toolbarHeight: 60,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          AppImages.backIcon,
          color: AppColors.greyBrightIconColor,
          size: 32,
        ),
      ),
      titleSpacing: 0,
      actions: [
        SizedBox(
          width: 80,
          height: 35,
          child: ReusableMaterialButton(
            elevation: 0,
            text: "Follow",
            onPressed: () {},
          ),
        ),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(padding: EdgeInsets.zero),
          icon: const Icon(
            AppImages.verticalMoreIcon,
            color: AppColors.greyBrightIconColor,
            size: 28,
          ),
        )
      ],
    );
  }
}
