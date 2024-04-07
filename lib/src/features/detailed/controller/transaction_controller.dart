import 'package:dio/dio.dart';

import '../../../../models/transaction_model.dart';
import '../../../../repositories/user_preferences.dart';
import '../../../../utils/constants/app_export.dart';

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  void fetchTransactions() async {
    try {
      isLoading(true);
      final response = await Dio().get(
          'https://notespaedia.deienami.com/api/financials/transaction_list_view/?user_id=${UserPreferences.userId}');
      var transactionsData =
          List<Map<String, dynamic>>.from(response.data['data']);
      transactions.value = transactionsData
          .map((jsonData) => Transaction.fromJson(jsonData))
          .toList();
    } finally {
      isLoading(false);
    }
  }
}
