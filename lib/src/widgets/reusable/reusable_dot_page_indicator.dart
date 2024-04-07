import 'package:notespedia/utils/constants/app_export.dart';

class ReusableDotPageIndicator extends StatelessWidget {
  const ReusableDotPageIndicator({
    super.key,
    required this.count,
    required this.controller,
    this.axisDirection,
    this.dotHeight,
    this.dotWidth,
    this.dotColor,
    this.activeDotColor,
    this.onDotClicked,
  });

  final int count;
  final PageController controller;
  final Axis? axisDirection;
  final double? dotHeight;
  final double? dotWidth;
  final Color? dotColor;
  final Color? activeDotColor;
  final void Function(int)? onDotClicked;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      count: count,
      controller: controller,
      onDotClicked: onDotClicked,
      axisDirection: axisDirection ?? Axis.horizontal,
      effect: ScrollingDotsEffect(
        fixedCenter: false,
        paintStyle: PaintingStyle.fill,
        activeDotColor: activeDotColor ?? AppColors.brightGreen,
        dotColor: dotColor ?? AppColors.dimGreen,
        activeDotScale: 1,
        dotHeight: dotHeight ?? 10,
        dotWidth: dotWidth ?? 10,
      ),
    );
  }
}
