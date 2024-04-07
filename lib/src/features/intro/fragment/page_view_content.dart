import 'package:notespedia/utils/constants/app_export.dart';

class PageViewContent extends StatelessWidget {
  const PageViewContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(DeviceHelper.getScreenHeight(context) * .14),
        Image.asset(
          image,
          fit: BoxFit.contain,
          isAntiAlias: true,
          filterQuality: FilterQuality.high,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 26,
                ),
          ),
        ),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
      ],
    );
  }
}
