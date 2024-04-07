import 'package:flutter/material.dart';
import 'package:gap/gap.dart'; // Make sure you have the gap package or replace Gap with SizedBox
import 'package:notespedia/utils/constants/app_export.dart'; // Ensure this has the necessary imports

class ContainerMyNotes extends StatelessWidget {
  const ContainerMyNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define the list of chip labels
    final List<String> chipLabels = [
      "Categories",
      "New Arrivals",
      "High to Low",
      "Low to High",
    ];

    return Card(
      elevation: .5,
      margin: EdgeInsets.zero,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: DeviceHelper.getScreenWidth(context) *
                  .85, // Ensure DeviceHelper is defined or replace with MediaQuery
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemBuilder: (context, index) {
                  // Use the index to get the corresponding label from the list
                  return ActionChip(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: .5,
                      ),
                    ),
                    label: Text(chipLabels[index]), // Set the label dynamically
                    onPressed: () {
                      // Handle chip press, potentially using index to differentiate actions
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(8);
                },
                itemCount: chipLabels
                    .length, // Set the itemCount to the length of the chipLabels list
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                AppImages
                    .toneIcon, // Ensure AppImages.toneIcon is defined in your constants
                size: 26,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
