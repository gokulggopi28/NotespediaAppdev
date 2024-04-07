import 'package:notespedia/utils/constants/app_export.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .30,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      alignment: Alignment.center,
      color: Colors.grey.withOpacity(.2),
      child: Image.asset(
        AppImages.appLogoWithName,
        height: 200,
        width: 200,
        fit: BoxFit.contain,
      ),
    );
  }
}
