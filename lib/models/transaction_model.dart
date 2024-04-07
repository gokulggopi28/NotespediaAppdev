class Transaction {
  final String orderId;
  final String amount;
  final String transactionFor;
  final String createdAt;
  final String transactionNumber;

  Transaction({
    required this.orderId,
    required this.amount,
    required this.transactionFor,
    required this.createdAt,
    required this.transactionNumber,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      orderId: json['order_id'],
      amount: json['amount'],
      transactionFor: json['transaction_for'],
      createdAt: json['created_at'],
      transactionNumber: json['transaction_number'],
    );
  }
}
