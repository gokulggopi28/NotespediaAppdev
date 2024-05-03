import '../../../utils/constants/app_export.dart';
import '../authentication/sign_in_with_mobile_screen.dart';
import 'dotted_line_seperator.dart';

void showCustomLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 320, // Adjust the size to fit your needs
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/png/login_alert.png',
                width: 66,
                height: 66,
              ),
              SizedBox(height: 10),
              Text(
                "Login to view all the chapters",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              // Custom dotted line separator
              CustomPaint(
                size:
                    Size(223, 1), // You can adjust the width to fit your needs
                painter: DottedLineSeparator(),
              ),
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
                  backgroundColor: Color(0xFF05CF64), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Get.to(() => SignInWIthMobileScreen());
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
