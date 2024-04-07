import 'package:notespedia/utils/constants/app_export.dart';

class ListviewSuggestedNotemakers extends StatelessWidget {
  const ListviewSuggestedNotemakers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: ListView.separated(
        itemCount: localSuggestedFriendsList.length,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        separatorBuilder: (context, index) {
          return const Gap(16.0);
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed("/friendsProfile");
            },
            child: Container(
              width: 170,
              decoration: const ShapeDecoration(
                color: AppColors.dimGreen,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.5,
                    color: AppColors.brightGreen,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: CircleBorder(),
                    ),
                    child: ReusableCachedNetworkImage(
                      imageUrl: localSuggestedFriendsList[index].profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(6),
                  Text(
                    'Sam John',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const Gap(2),
                  Text(
                    '25 Notes',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                          fontFamily: "Montserrat",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const Gap(8),
                  ReusableMaterialButton(
                    height: 30,
                    width: 90,
                    elevation: 0,
                    color: const Color(0xFF05CF64),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                    onPressed: () {},
                    text: 'Follow',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
