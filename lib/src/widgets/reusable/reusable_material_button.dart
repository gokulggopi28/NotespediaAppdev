import 'package:notespedia/utils/constants/app_export.dart';

class ReusableMaterialButton extends StatelessWidget {
  const ReusableMaterialButton({
    super.key,
    required this.onPressed,
    this.enableFeedback = true,
    this.width,
    this.height,
    this.text,
    this.onLongPress,
    this.maxWidth,
    this.minWidth,
    this.elevation = 0,
    this.hoverElevation = 0,
    this.focusElevation = 0,
    this.highlightElevation = 0,
    this.disabledElevation = 0,
    this.padding,
    this.textStyle,
    this.color,
    this.textColor,
    this.splashColor,
    this.hoverColor,
    this.highlightColor,
    this.focusColor,
    this.disabledColor,
    this.borderColor,
    this.shape,
    this.animationDuration,
    this.mouseCursor,
    this.child,
    this.disabledTextColor,
  });

  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final String? text;
  final Widget? child;
  final bool enableFeedback;
  final double? width, height, maxWidth, minWidth;
  final double? elevation,
      hoverElevation,
      focusElevation,
      highlightElevation,
      disabledElevation;

  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? color,
      textColor,
      splashColor,
      hoverColor,
      highlightColor,
      focusColor,
      disabledColor,
      disabledTextColor,
      borderColor;
  final ShapeBorder? shape;
  final Duration? animationDuration;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    final bool darkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 55,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? 600,
        minWidth: minWidth ?? 0.0,
      ),
      child: MaterialButton(
        height: height,
        onPressed: onPressed,
        onLongPress: onLongPress,
        elevation: elevation,
        hoverElevation: highlightElevation,
        focusElevation: focusElevation,
        highlightElevation: highlightElevation,
        disabledElevation: disabledElevation,
        enableFeedback: enableFeedback,
        animationDuration: animationDuration,
        color: color ?? (darkMode ? Colors.white : Colors.black),
        textColor: textColor ?? (darkMode ? Colors.black : Colors.white),
        hoverColor: hoverColor,
        splashColor: splashColor,
        highlightColor: highlightColor,
        disabledColor: disabledColor,
        disabledTextColor: disabledTextColor,
        mouseCursor: mouseCursor ?? SystemMouseCursors.click,
        padding: padding,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
        child: child ??
            Text(
              text!,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: textColor ??
                            (darkMode ? Colors.black : Colors.white),
                      ),
            ),
      ),
    );
  }
}
