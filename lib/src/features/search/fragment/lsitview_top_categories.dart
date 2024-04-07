import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:notespedia/models/books_search_model.dart'; // Adjust based on your project structure
import 'package:notespedia/src/features/home/categories_based_books_screen.dart';

class ListviewTopCategories extends StatelessWidget {
  ListviewTopCategories({Key? key}) : super(key: key);

  final SearchScreenController seController =
      Get.find<SearchScreenController>();
  final NetworkStateController nSController =
      Get.find<NetworkStateController>();

  final caController = Get.find<BooksCategoryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (seController.isProcessing.isTrue ||
          seController.hasError.isTrue ||
          seController.searchTopCategoriesList.isEmpty) {
        return topCategoriesLoadingShimmer();
      } else {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: seController.searchTopCategoriesList.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildCategoryChip(context, category),
              );
            }).toList(),
          ),
        );
      }
    });
  }

  Widget _buildCategoryChip(
      BuildContext context, SearchTopCategoriesList category) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [AppColors.dimContainerShadow],
      ),
      child: ActionChip(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        pressElevation: 3,
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
        shadowColor: const Color(0xff8a959e).withOpacity(.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide.none,
        avatar: SizedBox(
          height: 28,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ReusableCachedNetworkImage(
              imageUrl: category.categoryIcon,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        label: Text(
          category.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          final selectedCategoryId = category.id;
          if (nSController.isInternetConnected.isTrue) {
            caController.onCategorySelection(selectedCategoryId);
          } else {
            HelperFunctions.showSnackBar(
                context: context, message: "No Internet Connection");
          }
          Get.to(() => CategoryBasedBooksScreen());
        },
      ),
    );
  }

  Widget topCategoriesLoadingShimmer() {
    return SizedBox(
      height: 135,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 100,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
