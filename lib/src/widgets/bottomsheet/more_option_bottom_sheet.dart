import 'package:notespedia/utils/constants/app_export.dart';

Future<dynamic> moreOptionsBottomSheetForContinueReading(
    BuildContext context, int selectedIndex) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    showDragHandle: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.0),
        topRight: Radius.circular(26.0),
      ),
    ),
    constraints: BoxConstraints.tight(
      Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * .4,
      ),
    ),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 1.5,
                color: Colors.grey.withOpacity(.5),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(),
                          child: const Icon(
                            AppImages.updateIcon,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Gap(22),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(),
                          child: const Icon(
                            AppImages.shareIcon,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const Gap(22),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(),
                          child: const Icon(
                            AppImages.bookmarkIcon,
                            size: 26,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
