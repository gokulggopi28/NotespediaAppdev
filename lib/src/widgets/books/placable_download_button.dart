import 'package:notespedia/utils/constants/app_export.dart';

class PlaceableDownloadButton extends StatelessWidget {
  const PlaceableDownloadButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
        ),
        icon: const Icon(
          AppImages.downloadIcon,
          size: 22,
          color: AppColors.brightGreen,
        ),
      ),
    );
  }
}
