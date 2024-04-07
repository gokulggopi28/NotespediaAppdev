import 'package:cached_network_image/cached_network_image.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class ReusableCachedNetworkImage extends StatelessWidget {
  const ReusableCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.filterQuality,
    this.color,
    this.colorBlendMode,
    this.placeholderIndicatorEnable = true,
    this.progressIndicatorEnable = false,
    this.errorWidgetEnable = false,
    this.maxHeightDiskCache,
    this.maxWidthDiskCache,
    this.errorWidget,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;
  final FilterQuality? filterQuality;
  final Color? color;
  final BlendMode? colorBlendMode;
  final bool placeholderIndicatorEnable;
  final bool progressIndicatorEnable;
  final bool errorWidgetEnable;
  final Widget? errorWidget;
  final int? maxHeightDiskCache;
  final int? maxWidthDiskCache;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.contain,
      alignment: alignment ?? Alignment.center,
      filterQuality: filterQuality ?? FilterQuality.high,
      maxHeightDiskCache: maxHeightDiskCache,
      maxWidthDiskCache: maxWidthDiskCache,
      matchTextDirection: true,
      color: color,
      colorBlendMode: colorBlendMode,
      errorListener: (value) {
        return DebugLogger.error("Network Image Error: $value");
      },
      errorWidget: errorWidgetEnable
          ? (context, url, error) {
              return errorWidget ??
                  const Icon(
                    AppImages.imageIcon,
                    color: Colors.grey,
                    size: 32,
                  );
            }
          : null,
      placeholder: placeholderIndicatorEnable
          ? (context, url) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.white,
                ),
              );
            }
          : null,
      progressIndicatorBuilder: progressIndicatorEnable
          ? (context, url, progress) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  value: progress.progress,
                ),
              );
            }
          : null,
    );
  }
}
