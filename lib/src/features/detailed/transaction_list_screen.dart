import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controller/transaction_controller.dart';

class TransactionListScreen extends StatelessWidget {
  final TransactionController transactionController =
      Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: Obx(() {
        if (transactionController.isLoading.isTrue) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var transaction =
                          transactionController.transactions[index];
                      return Card(
                        margin: EdgeInsets.only(
                            bottom: 8), // Small gap between cards
                        elevation: 0, // Removes shadow
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transaction.orderId,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "₹${transaction.amount}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "${transaction.transactionFor} ", // Transaction for text
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                            0xFF05CF64), // Green color for "transaction for"
                                      ),
                                    ),
                                    TextSpan(
                                      text: DateFormat('dd-MMMM-yyyy').format(
                                          DateTime.parse(
                                              transaction.createdAt)),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                            0xFF4F4F4FB2), // Gray color for "created at" date
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: transactionController.transactions.length,
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
