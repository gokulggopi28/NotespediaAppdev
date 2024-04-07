import 'dart:convert';

import 'package:notespedia/utils/constants/app_export.dart';

class ExplorerItemController extends GetxController {
  //
  final networkStateController = Get.find<NetworkStateController>();
  final isProcessing = false.obs;
  final hasError = false.obs;

  final explorerItemList = <ExplorerItemList>[].obs;

  @override
  void onInit() {
    fetchExplorerItem();
    super.onInit();
  }

  Future<void> fetchExplorerItem() async {
    if (networkStateController.isInternetConnected.isTrue) {
      try {
        isProcessing(true);
        final response = await HttpService.dioGetRequest(
            url: "${ApiConstants.baseUrl}common/explore_items");
        if (response.statusCode == 200) {
          final jsonData =
              bookExplorerModelFromJson(json.encode(response.data));
          explorerItemList.addAll(jsonData.explorerItem);
        } else if (response.statusCode! >= 400 && response.statusCode! < 500) {
          DebugLogger.warning('Client Side error: ${response.statusCode}');
          hasError(true);
        } else if (response.statusCode! >= 500 && response.statusCode! < 600) {
          DebugLogger.warning('Server Side error: ${response.statusCode}');
          hasError(true);
        } else {
          DebugLogger.warning('${response.statusCode}');
          hasError(true);
        }
      } catch (error) {
        hasError(true);
        DebugLogger.error(error.toString());
      } finally {
        isProcessing(false);
      }
    } else {
      hasError(true);
      DebugLogger.warning("No Internet");
    }
  }

  Future<void> refreshExplorerItems() async {
    if (networkStateController.isInternetConnected.isTrue) {
      if (isProcessing.isFalse) {
        hasError(false);
        explorerItemList.clear();
        await fetchExplorerItem();
      } else if (hasError.isTrue) {
        hasError(false);
        explorerItemList.clear();
        await fetchExplorerItem();
      }
    } else {
      return;
    }
  }
}
