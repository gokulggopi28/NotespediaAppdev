import 'package:flutter/material.dart';
import 'package:notespedia/src/features/home/first_home_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import your homepage screen accordingly

class CheckoutWebViewScreen extends StatefulWidget {
  final String checkoutUrl;

  const CheckoutWebViewScreen({Key? key, required this.checkoutUrl})
      : super(key: key);

  @override
  State<CheckoutWebViewScreen> createState() => _CheckoutWebViewScreenState();
}

class _CheckoutWebViewScreenState extends State<CheckoutWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Check if it's possible to pop the current route.
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current route.
            return false; // Prevent the system from popping the route, as we've handled it manually.
          }
          return true; // Allow the system to handle the back button (e.g., exiting the app) if no routes to pop.
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Checkout"),
          ),
          body: WebView(
            initialUrl: widget.checkoutUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));
  }
}
