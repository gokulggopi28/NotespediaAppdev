import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure you have GetX imported for navigation
import '../../../utils/constants/app_export.dart';
import 'fragment/unsubscibedshelf_image.dart';
import 'fragment/unsubscribed_shelf_text.dart'; // Ensure this path is correct

class UnSubscribedShelf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get
                .back(), // Uses GetX for navigation. Adjust if not using GetX
          ),
          title: Text("Subscription Details"),
        ),
        body: Center(
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Center the column content vertically
            children: <Widget>[
              ResponsiveImage(), // Your ResponsiveImage widget
              SizedBox(height: 20), // Space between image and the first text
              CustomTextWidget(
                text: "Unlock Premium Features with Our Exclusive Shelf",
                fontWeight: FontWeight.w600, // Bold text
                color: Colors.black,
              ),
              SizedBox(height: 13), // Space between the two texts
              CustomTextWidget(
                text: "Enhance Your Reading Experience with Advanced Tools",
                fontWeight: FontWeight.w400, // Regular weight text
                color: Color(0x80000000), // Semi-transparent black
              ),
              SizedBox(height: 20), // Space before the button
              Align(
                alignment:
                    Alignment.centerLeft, // Aligns the button to the left
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 125), // Adjusts how far left the button is
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.premiumPlansRoute);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF05CF64), // Background color
                      onPrimary: Colors.white, // Text color
                      fixedSize: Size(123, 37), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Border radius
                      ),
                    ),
                    child: Text(
                      "Subscribe",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
