import 'package:notespedia/src/features/offline/downloded_screen_appbar.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DownloadScreenAppbars(
        onPressed: () {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            //
            Container(
              width: double.infinity,
              height: 35,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(color: Color(0xFF4B4B4B)),
              child: Text(
                'No internet connection',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 235,
              height: 175,
              child: Image.asset(
                AppImages.noWifiIcon,
                fit: BoxFit.contain,
                isAntiAlias: true,
              ),
            ),

            //
            const Gap(26),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                'You’re currently offline',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0),
              child: Text(
                "We weren’t able to load the content without an internet connection. "
                "\nPlease check your connection",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed("/downloads");
              },
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFF0678CE),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
              child: const Text('Go to Downloads'),
            ),

            //
            const Spacer(),
            SizedBox(height: DeviceHelper.getBottomNavigationBarHeight()),
          ],
        ),
      ),
    );
  }
}
