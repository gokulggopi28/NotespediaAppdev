import 'package:notespedia/utils/constants/app_export.dart';

class ReusableLinearProgressIndicator extends StatelessWidget {
  const ReusableLinearProgressIndicator({
    super.key,
    required this.value,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.color,
  });

  final double value;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 115,
      height: height ?? 5,
      child: ClipRRect(
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor ?? Colors.grey.shade300,
          color: color ?? const Color(0xff09cf64),
        ),
      ),
    );
  }
}
