import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class AddToCartOutlineButton extends StatefulWidget {
  final int selectedBookId;

  const AddToCartOutlineButton({
    Key? key,
    required this.selectedBookId,
  }) : super(key: key);

  @override
  _AddToCartOutlineButtonState createState() => _AddToCartOutlineButtonState();
}

class _AddToCartOutlineButtonState extends State<AddToCartOutlineButton> {
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: OutlinedButton.icon(
        onPressed: () async {
          if (!isAddedToCart) {
            // Assuming you have a method in your cart controller to handle adding items
            // You might need to adjust this part based on how your cart management is set up
            await Get.find<CartAndOrderController>().onTapOnCartAction(
              ctx: context,
              selectedBookId: widget.selectedBookId,
            );
            setState(() {
              isAddedToCart =
                  true; // Update the state to reflect the item has been added to cart
            });
          } else {
            // Navigate to the cart page if the item has been added
            Get.toNamed("/cart");
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF05CF64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Color(0xFF05CF64), width: 1.5),
        ),
        icon:
            const Icon(AppImages.cartIcon, color: Color(0xFF05CF64), size: 24),
        label: Text(
          isAddedToCart
              ? 'View Cart'
              : 'Add to Cart', // Change the text based on the item's cart status
          style: const TextStyle(
            color: Color(0xFF05CF64),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
