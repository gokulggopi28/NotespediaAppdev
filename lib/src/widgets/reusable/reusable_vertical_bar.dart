import 'package:notespedia/utils/constants/app_export.dart';

class ReusableVerticalBar extends StatelessWidget {
  const ReusableVerticalBar({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1,
      height: height ?? 40,
      color: color ?? AppColors.greyDim,
    );
  }
}
