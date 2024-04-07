import 'package:notespedia/utils/constants/app_export.dart';

class SliverFlexibleSpace extends StatelessWidget {
  const SliverFlexibleSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 105.w),
        child: const Image(
          isAntiAlias: true,
          alignment: Alignment.center,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          semanticLabel: AppTexts.appName,
          image: AssetImage(
            AppImages.appLogoWithName,
          ),
        ),
      ),
    );
  }
}
