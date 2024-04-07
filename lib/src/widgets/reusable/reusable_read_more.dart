import 'package:flutter/material.dart';
import 'package:notespedia/utils/constants/app_colors.dart';

class ReusableReadMore extends StatefulWidget {
  const ReusableReadMore({
    super.key,
    required this.text,
    required this.maxLines,
  });

  final String text;
  final int maxLines;

  @override
  State<ReusableReadMore> createState() => _ReusableReadMoreState();
}

class _ReusableReadMoreState extends State<ReusableReadMore> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: isExpanded,
          child: Text(
            widget.text,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        Visibility(
          visible: !isExpanded,
          child: Text(
            widget.text,
            maxLines: widget.maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: FractionalOffset.centerRight,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read Less' : 'Read More',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.greenIndicator,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
