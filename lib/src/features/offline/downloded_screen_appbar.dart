import 'package:notespedia/utils/constants/app_export.dart';

class DownloadScreenAppbars extends StatelessWidget
    implements PreferredSizeWidget {
  const DownloadScreenAppbars({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: const Color(0xfffaf6f6),
      foregroundColor: Colors.black,
      shadowColor: Colors.black,
      elevation: 0.5,
      scrolledUnderElevation: 0.5,
      clipBehavior: Clip.antiAlias,
      toolbarHeight: 60.0,
      titleSpacing: 0.0,
      iconTheme: const IconThemeData(size: 24, color: Colors.black),
      leading: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          AppImages.menu,
          height: 32,
          width: 32,
          fit: BoxFit.contain,
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   AppTexts.appName,
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 20,
          //     fontWeight: FontWeight.w500,
          //     height: 0,
          //   ),
          // ),
          // Consumer<CommonProvider>(
          //   builder: (context, appbarNotifier, child) {
          //     return DropdownButton<String>(
          //       padding: EdgeInsets.zero,
          //       isDense: true,
          //       icon: const Icon(
          //         AppImages.dropDownIcon,
          //         size: 24,
          //       ),
          //       iconSize: 24,
          //       style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //             color: Colors.black,
          //             fontSize: 12,
          //             fontWeight: FontWeight.w400,
          //           ),
          //       underline: Container(),
          //       value: appbarNotifier.selectedAppbarDropdownItem,
          //       onChanged: (newValue) {
          //         appbarNotifier.setSelectedDropdownItem(newValue!);
          //       },
          //       items: appbarNotifier.appbarDropdownItems
          //           .map((value) => DropdownMenuItem<String>(
          //                 value: value,
          //                 child: Text(value),
          //               ))
          //           .toList(),
          //     );
          //   },
          // ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            AppImages.searchIcon,
            size: 24,
            semanticLabel: "Search",
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            AppImages.cartIcon,
            size: 24,
            semanticLabel: "Cart",
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            AppImages.notificationIcon,
            size: 24,
            semanticLabel: "Notification",
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
