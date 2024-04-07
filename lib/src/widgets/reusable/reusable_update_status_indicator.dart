import 'package:notespedia/utils/constants/app_export.dart';

class ReusableUpdateStatusIndicator extends StatelessWidget {
  const ReusableUpdateStatusIndicator({
    super.key,
    this.color,
    this.radius,
    this.elevation,
  });

  final Color? color;
  final double? radius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 4,
      backgroundColor: color ?? AppColors.redIndicator,
    );
  }
}
