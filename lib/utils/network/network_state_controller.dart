import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:notespedia/utils/helpers/debug_logger.dart';

class NetworkStateController extends GetxController {
  //
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  var isInternetConnected = true.obs;
  var hasInternet = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize connectivity status
    checkInternetConnectivity();

    // Listen to network changes
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      isInternetConnected.value = result != ConnectivityResult.none;
      DebugLogger.warning("Internet Connection: ${isInternetConnected.value}");
    });
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    hasInternet.value = connectivityResult != ConnectivityResult.none;
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
