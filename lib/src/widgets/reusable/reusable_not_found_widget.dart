import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ReusableResultNotFoundWidget extends StatelessWidget {
  const ReusableResultNotFoundWidget({
    super.key,
    this.title,
    this.addOnTitle,
    this.subTitle,
    this.bottomPadding = 0,
  });

  final String? title;
  final String? addOnTitle;
  final String? subTitle;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: bottomPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/svg/not_found.svg",
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height * .25,
          ),
          Text(
            title == null
                ? (addOnTitle == null
                    ? "Couldn't find any result"
                    : "Couldn't find any result $addOnTitle")
                : title.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Gap(8),
          Text(
            subTitle ??
                "Try searching for something else or try \nwith a different spelling",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
