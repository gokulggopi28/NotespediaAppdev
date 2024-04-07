import '../../../../utils/constants/app_export.dart';

class ResponsiveImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var imageSize =
        size.width * 0.4; // Example to scale image size proportionally

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/png/ebook.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
