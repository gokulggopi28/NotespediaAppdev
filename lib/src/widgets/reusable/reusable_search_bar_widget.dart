import 'package:notespedia/utils/constants/app_export.dart';

class ReusableSearchBarWidget extends StatefulWidget {
  const ReusableSearchBarWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  State<ReusableSearchBarWidget> createState() =>
      _ReusableSearchBarWidgetState();
}

class _ReusableSearchBarWidgetState extends State<ReusableSearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        color: Colors.white,
        shadows: [
          AppColors.containerShadow,
        ],
      ),
      child: SearchBar(
        controller: widget.searchController,
        backgroundColor: const MaterialStatePropertyAll(Colors.white),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.white),
        elevation: const MaterialStatePropertyAll(0),
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        padding:
            const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(26)),
          ),
        ),
        textStyle: MaterialStatePropertyAll(
          Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 14,
                fontFamily: "Montserrat",
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
        ),
        hintText: AppTexts.searchHint,
        hintStyle: MaterialStatePropertyAll(
          Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 12,
                fontFamily: "Montserrat",
                color: const Color(0xffb8b8b8),
                fontWeight: FontWeight.w600,
              ),
        ),
        leading: const Icon(
          AppImages.searchIcon,
          color: Color(0xffb8b8b8),
          size: 22,
        ),
      ),
    );
  }
}
