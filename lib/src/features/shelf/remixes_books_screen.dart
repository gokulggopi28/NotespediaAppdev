import 'package:notespedia/utils/constants/app_export.dart';

class RemixesBooksScreen extends StatelessWidget {
  const RemixesBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        physics: const ClampingScrollPhysics(),
        slivers: [
          //
          const ReusableBackSliverAppbar(titleText: "Remixes"),

          //
          const SliverGap(18),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverAnimatedGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 300,
                maxCrossAxisExtent: 170,
                crossAxisSpacing: 22,
                mainAxisSpacing: 22,
              ),
              itemBuilder: (context, index, animation) {
                return SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BookCard(
                          imageUrl:
                              localFreshReleaseBooksList[index].bookCoverImg,
                          onTap: () {
                            Get.toNamed("/bookDetails");
                          },
                        ),
                      ),
                      const Gap(6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: BookTitle14(title: "J.K. Rowling."),
                          ),
                          const Gap(6),
                          ReusableMoreOptionButton(
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Container(
                        width: 65,
                        height: 25,
                        alignment: index == 0
                            ? AlignmentDirectional.center
                            : Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          color: index == 0 ? Colors.white : Colors.transparent,
                          border: Border.all(
                            color:
                                index == 0 ? Colors.grey : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          index == 0
                              ? "Publish"
                              : (index == 1 ? "Published" : "Rejected"),
                          maxLines: 1,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: index == 0
                                        ? Colors.black
                                        : index == 1
                                            ? Colors.green
                                            : Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              initialItemCount: localFreshReleaseBooksList.length,
            ),
          ),

          //
          const SliverGap(42),
        ],
      ),
    );
  }
}
