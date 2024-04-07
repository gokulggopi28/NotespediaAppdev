import 'package:notespedia/utils/constants/app_export.dart';

class ReusableOngoingStatusIndicator extends StatelessWidget {
  const ReusableOngoingStatusIndicator({
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
      backgroundColor: color ?? AppColors.yellowIndicator,
    );
  }
}
