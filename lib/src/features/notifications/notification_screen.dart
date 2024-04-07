import 'package:notespedia/utils/constants/app_export.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //
  bool loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const ReusableBackSliverAppbar(titleText: AppTexts.notification),
          if (loading)
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ReusableCircularProgressIndicator(),
                  SizedBox(height: DeviceHelper.getBottomNavigationBarHeight()),
                ],
              ),
            )
          else
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    AppImages.notificationIcon,
                    size: 110,
                    color: AppColors.greyBrightIconColor,
                  ),
                  const Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      AppTexts.noNotification,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black.withOpacity(0.69),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  const Gap(22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52.0),
                    child: Text(
                      AppTexts.notificationInfo,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  SizedBox(height: DeviceHelper.getBottomNavigationBarHeight()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
