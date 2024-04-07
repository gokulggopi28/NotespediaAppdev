import 'package:notespedia/utils/constants/app_export.dart';

class HardAndSoftCopy extends StatelessWidget {
  const HardAndSoftCopy({
    super.key,
    required this.instanceData,
  });

  final BookDetailData instanceData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              splashColor: const Color(0xFF05CF64).withOpacity(.07),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                  bottom: 8,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFF05CF64),
                      width: 1.5,
                    ),
                    top: BorderSide(
                      color: Color(0xFF05CF64),
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF05CF64),
                      width: 1.5,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Hardcopy',
                          style: TextStyle(
                            color: Color(0xFF05CF64),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        const Gap(2),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "₹ ${instanceData.hardCopyOldPrice}",
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: const Color(0xFF05CF64),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  decoration: TextDecoration.lineThrough,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      "₹ ${instanceData.hardCopyNewPrice}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF05CF64),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const ReusableVerticalBar(
            height: double.maxFinite,
            color: Color(0xFF05CF64),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              splashColor: const Color(0xFF05CF64).withOpacity(.07),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 8,
                  bottom: 8,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Color(0xFF05CF64),
                      width: 1.5,
                    ),
                    top: BorderSide(
                      color: Color(0xFF05CF64),
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFF05CF64),
                      width: 1.5,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Softcopy',
                          style: TextStyle(
                            color: Color(0xFF05CF64),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        const Gap(2),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "₹ ${instanceData.hardCopyOldPrice}",
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: const Color(0xFF05CF64),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  decoration: TextDecoration.lineThrough,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      "₹ ${instanceData.hardCopyNewPrice}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF05CF64),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
