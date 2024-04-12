import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../models/transaction_model.dart';
import '../../../../repositories/user_preferences.dart';

class TransactionController extends GetxController {
  var isLoading = true.obs;
  var transactionList = <Transaction>[].obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  void fetchTransactions() async {
    isLoading(true);
    try {
      var userId =
          UserPreferences.userId; // Assume this exists and fetches the user ID
      var response = await http.get(Uri.parse(
          'https://notespaedia.deienami.com/api/financials/transaction_list_view/?user_id=$userId'));
      if (response.statusCode == 200) {
        var transactionsJson = json.decode(response.body)['data'] as List;
        var transactions =
            transactionsJson.map((data) => Transaction.fromJson(data)).toList();
        transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        transactionList.assignAll(transactions);
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
