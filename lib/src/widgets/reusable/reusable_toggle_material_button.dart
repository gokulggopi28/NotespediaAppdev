import 'package:notespedia/utils/constants/app_export.dart';

class ReusableToggleMaterialButton extends StatelessWidget {
  const ReusableToggleMaterialButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.green.shade50 : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.green.shade100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(),
            ),
          ),
        ),
      ),
    );
  }
}
