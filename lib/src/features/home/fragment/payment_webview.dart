import 'package:flutter/material.dart';
import 'package:notespedia/src/features/navigation/home_screen.dart';
import 'package:notespedia/src/features/navigation/navigationController.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../utils/constants/app_export.dart';
import '../first_home_page.dart'; // Ensure you have the correct path to FirstHomePage

class PaymentWebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentWebViewScreen({Key? key, required this.paymentUrl})
      : super(key: key);

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: WebView(
        initialUrl: widget.paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains("thank_you")) {
            // Detected the success URL
            // Wait for 7 seconds before showing the success alert
            Future.delayed(Duration(seconds: 30), () {
              // Show payment success message
              showDialog(
                context: context,
                barrierDismissible:
                    false, // User must tap button for close dialog
                builder: (BuildContext context) {
                  // Auto close after 4 seconds
                  Future.delayed(Duration(seconds: 4), () {
                    Navigator.of(context).pop(); // Close the dialog
                    Get.find<NavigationController>()
                        .changeIndex(0); // Set selectedIndex to 3
                    Get.to(() => HomeScreen());
                  });
                  return AlertDialog(
                    title: Text("Payment Success"),
                    content: Text("Your payment was successful!"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          // Navigate to the homepage
                          Get.find<NavigationController>()
                              .changeIndex(0); // Set selectedIndex to 3
                          Get.to(() => HomeScreen());
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            });
            // Prevent loading the "thank_you" URL in the WebView
            return NavigationDecision.prevent;
          }
          // Allow navigation for other URLs
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
