import '../../../../utils/constants/app_export.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;

  const CustomTextWidget({
    Key? key,
    required this.text,
    required this.fontWeight,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 16.0), // Ensure some padding for responsiveness
      child: Text(
        text,
        textAlign: TextAlign.center, // Adjust based on your preference
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: fontWeight,
          color: color,
          height:
              1.25, // Flutter uses fontSize as base, 15px line height over 12px font size
        ),
      ),
    );
  }
}
