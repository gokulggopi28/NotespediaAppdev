import 'package:flutter/material.dart';
import 'package:notespedia/utils/constants/app_export.dart'; // Ensure correct import path

class ReusableSearchBarFormField extends StatelessWidget {
  const ReusableSearchBarFormField({
    super.key,
    this.searchController,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
  });

  final TextEditingController? searchController;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final searchScreenController = Get.find<SearchScreenController>();
    return Container(
      height: 50,
      padding: const EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: 8.0,
        bottom: 8.0,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        color: Colors.white,
        shadows: [AppColors.containerShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: () {
                searchScreenController.clearSearchData();
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.greyDimIconColor,
                size: 22,
              ),
            ),
            const Gap(6),
            Expanded(
              child: TextFormField(
                controller: searchController,
                keyboardType: TextInputType.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                onTap: onTap,
                onChanged: onChanged,
                onEditingComplete: onEditingComplete,
                decoration: InputDecoration(
                  hintText: AppTexts.searchHint,
                  hintTextDirection: TextDirection.ltr,
                  hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        color: AppColors.greyDimIconColor,
                        fontWeight: FontWeight.w600,
                      ),
                  filled: true,
                  isCollapsed: true,
                  isDense: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
