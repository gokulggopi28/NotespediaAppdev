import 'package:notespedia/utils/constants/app_export.dart';

class BookStackCard extends StatelessWidget {
  const BookStackCard({
    super.key,
    required this.widget,
    this.width,
    this.height,
    this.borderRadiusGeometry,
    this.errorWidgetEnable,
  });

  final Widget widget;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool? errorWidgetEnable;

  @override
  Widget build(BuildContext context) {
    double defaultWidth = 170.w; // Use .w for responsive width
    double defaultHeight = 280.h;
    return PhysicalModel(
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(8.0.r),
      elevation: 4.0,
      shape: BoxShape.rectangle,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width ?? defaultWidth,
        height: height ?? defaultHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0.r),
          child: widget,
        ),
      ),
    );
  }
}
