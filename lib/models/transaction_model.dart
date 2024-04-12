class Transaction {
  final int id;
  final int userId;
  final String orderId;
  final String amount;
  final String transactionType;
  final String? transactionFor;
  final String status;
  final String sourceName;
  final String currencyCode;
  final String gateway;
  final String createdAt;
  final String transactionNumber;

  Transaction({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.amount,
    required this.transactionType,
    this.transactionFor,
    required this.status,
    required this.sourceName,
    required this.currencyCode,
    required this.gateway,
    required this.createdAt,
    required this.transactionNumber,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      orderId: json['order_id'],
      amount: json['amount'],
      transactionType: json['transaction_type'],
      transactionFor: json['transaction_for'],
      status: json['status'],
      sourceName: json['source_name'],
      currencyCode: json['currency_code'] ?? 'N/A', // Handle potential nulls
      gateway: json['gateway'],
      createdAt: json['created_at'],
      transactionNumber: json['transaction_number'],
    );
  }
}
