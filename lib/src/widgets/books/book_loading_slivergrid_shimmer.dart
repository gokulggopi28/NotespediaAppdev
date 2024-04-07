import 'package:notespedia/utils/constants/app_export.dart';

class BookLoadingSliverGridShimmer extends StatelessWidget {
  const BookLoadingSliverGridShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 300,
          maxCrossAxisExtent: 170,
          crossAxisSpacing: 22,
          mainAxisSpacing: 22,
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                const Gap(6),
                Container(
                  height: 8,
                  width: 170,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                const Gap(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Container(
                      height: 8,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: 12,
      ),
    );
  }
}
