import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_export.dart';

void showCustomSubscribeDialog(BuildContext context,
    {required VoidCallback onCancel}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              margin: EdgeInsets.only(
                  top: 15), // To avoid overlap of the close button by content
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Unlimited Power",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000D9),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Subscribe to our PRO Plans and unlock unlimited contents and features",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF05CF64),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Get.toNamed(AppRoutes.premiumPlansRoute);
                    },
                    child: Text("Subscribe"),
                  ),
                ],
              ),
            ),
            // Close button at the top right
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  onCancel(); // Trigger the onCancel callback
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
