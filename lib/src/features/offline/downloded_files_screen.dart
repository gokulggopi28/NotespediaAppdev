import 'package:notespedia/src/features/offline/downloded_screen_appbar.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class DownloadedFileScreen extends StatelessWidget {
  const DownloadedFileScreen({super.key});

  final bool noContent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DownloadScreenAppbars(
        onPressed: () {},
      ),
      body: noContent
          ? SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 35,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF05CF64),
                    ),
                    child: Text(
                      'Back online',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                    ),
                  ),
                  const Gap(30),
                  Container(
                    width: 234,
                    height: 173,
                    decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                  ),
                  const Gap(26),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Text(
                      'You have no downloaded content',
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
                      'Download content to read anywhere and anytime',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: DeviceHelper.getBottomNavigationBarHeight(),
                  ),
                ],
              ),
            )
          : const CustomScrollView(
              slivers: [],
            ),
    );
  }
}
