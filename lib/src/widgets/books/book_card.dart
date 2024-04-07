import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.width,
    this.height,
    this.borderRadiusGeometry,
    this.errorWidgetEnable,
  });

  final String imageUrl;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadiusGeometry;
  final bool? errorWidgetEnable;

  @override
  Widget build(BuildContext context) {
    // Default sizes with responsive scaling
    double defaultWidth = 170.w; // Use .w for responsive width
    double defaultHeight = 280.h; // Use .h for responsive height

    return GestureDetector(
      onTap: onTap,
      child: PhysicalModel(
        color: Colors.white,
        shadowColor: Colors.grey.shade300,
        borderRadius:
            BorderRadius.circular(8.r), // Use .r for responsive radius
        elevation: 4.0,
        shape: BoxShape.rectangle,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: width ?? defaultWidth,
          height: height ?? defaultHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: ReusableCachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              maxWidthDiskCache: 1024,
              maxHeightDiskCache: 1024,
              errorWidgetEnable: errorWidgetEnable ?? true,
              errorWidget: Padding(
                padding: EdgeInsets.all(26.0.w),
                child: Image.asset(
                  AppImages.imageGalleryIcon,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
