class Plan {
  final int id;
  final String planName;
  final String image;
  final String description;
  final List<SubscriptionScheme> subscriptionSchemes;

  Plan({
    required this.id,
    required this.planName,
    required this.image,
    required this.description,
    required this.subscriptionSchemes,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    var list = json['subscription_schemes'] as List;
    List<SubscriptionScheme> schemesList =
        list.map((i) => SubscriptionScheme.fromJson(i)).toList();

    return Plan(
      id: json['id'],
      planName: json['plan_name'],
      image: json['image'],
      description: json['description'],
      subscriptionSchemes: schemesList,
    );
  }
}

class SubscriptionScheme {
  final int id;
  final int planId;
  final int durationMonths;
  final String durationLabel;
  final String subscriptionAmount;
  final String applePaySubscriptionAmount;
  final String googlePaySubscriptionAmount;
  final String productId;
  final String description;

  SubscriptionScheme({
    required this.id,
    required this.planId,
    required this.durationMonths,
    required this.durationLabel,
    required this.subscriptionAmount,
    required this.applePaySubscriptionAmount,
    required this.googlePaySubscriptionAmount,
    required this.productId,
    required this.description,
  });

  factory SubscriptionScheme.fromJson(Map<String, dynamic> json) {
    return SubscriptionScheme(
      id: json['id'],
      planId: json['plan_id'],
      durationMonths: json['duration_months'],
      durationLabel: json['duration_label'],
      subscriptionAmount: json['subscription_amount'],
      applePaySubscriptionAmount: json['apple_pay_subscription_amount'],
      googlePaySubscriptionAmount: json['google_pay_subscription_amount'],
      productId: json['product_id'],
      description: json['description'],
    );
  }
}
