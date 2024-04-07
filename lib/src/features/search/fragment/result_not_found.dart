import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:notespedia/utils/constants/app_export.dart';

class ResultNotFound extends StatelessWidget {
  ResultNotFound({super.key});

  final seController = Get.find<SearchScreenController>();

  @override
  Widget build(BuildContext context) {
    // Check if the search text is empty to determine the message to display
    bool isSearchEmpty = seController.searchTextController.text.trim().isEmpty;

    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isSearchEmpty
                  ? "Start Searching"
                  : "Couldn't find ${seController.searchTextController.text}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(8),
            Text(
              isSearchEmpty
                  ? "Type anything to start searching"
                  : "Try searching for something else or try \nwith a different spelling",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
