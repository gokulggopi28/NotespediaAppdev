import 'package:notespedia/utils/constants/app_export.dart';

class ReusableFloatingActionButton extends StatelessWidget {
  const ReusableFloatingActionButton({
    super.key,
    required this.iconName,
    required this.icon,
    this.elevation,
    this.onPressed,
  });

  final String iconName;
  final IconData icon;
  final double? elevation;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: elevation ?? 0,
      highlightElevation: elevation ?? 0,
      hoverElevation: elevation ?? 0,
      focusElevation: elevation ?? 0,
      tooltip: iconName,
      heroTag: iconName,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      enableFeedback: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.black,
        size: 26,
        semanticLabel: iconName,
      ),
    );
  }
}
