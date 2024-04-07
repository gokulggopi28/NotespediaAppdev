import 'package:notespedia/utils/constants/app_export.dart';

class ReusableDragHandler extends StatelessWidget {
  const ReusableDragHandler({
    super.key,
    this.width,
    this.height,
    this.color,
  });

  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 75,
      height: height ?? 4,
      decoration: BoxDecoration(
        color: color ?? AppColors.greyBrightIconColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}
