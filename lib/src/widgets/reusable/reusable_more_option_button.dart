import 'package:notespedia/utils/constants/app_export.dart';

class ReusableMoreOptionButton extends StatelessWidget {
  const ReusableMoreOptionButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 30,
      alignment: Alignment.center,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        iconSize: 24,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        icon: const Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Icon(
            AppImages.horizontalMoreIcon,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
