import 'package:notespedia/utils/constants/app_export.dart';

class ListviewTagChips extends StatelessWidget {
  const ListviewTagChips({
    super.key,
    required this.instanceData,
  });

  final BookDetailData instanceData;

  @override
  Widget build(BuildContext context) {
    if (instanceData.tags.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        height: 45,
        width: double.infinity,
        child: ListView.separated(
          itemCount: instanceData.tags.length,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          separatorBuilder: (context, index) {
            return const Gap(8);
          },
          itemBuilder: (context, index) {
            return ActionChip(
              onPressed: () {},
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              side: const BorderSide(
                width: 1,
                color: Color(0xFFD9D9D9),
                style: BorderStyle.solid,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              labelPadding: EdgeInsets.zero,
              label: Text(
                instanceData.tags[index].tagName,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            );
          },
        ),
      );
    }
  }
}
