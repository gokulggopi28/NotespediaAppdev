import 'package:notespedia/utils/constants/app_export.dart';

class ListviewRemixesBooks extends StatelessWidget {
  const ListviewRemixesBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 357,
      width: double.infinity,
      child: ListView.separated(
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        separatorBuilder: (context, index) {
          return const Gap(22);
        },
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BookCard(
                    imageUrl:
                        "https://s26162.pcdn.co/wp-content/uploads/2019/01/A1ydJm-AvL.jpg",
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
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: index == 0 ? Colors.white : Colors.transparent,
                    border: Border.all(
                      color: index == 0 ? Colors.grey : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    index == 0
                        ? "Publish"
                        : (index == 1 ? "Published" : "Rejected"),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
      ),
    );
  }
}
