import 'package:flutter/material.dart';

class ReusableCircularProgressIndicator extends StatelessWidget {
  const ReusableCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(10.0),
        child: const CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
