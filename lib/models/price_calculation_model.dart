// To parse this JSON data, do
//
//     final priceCalculationModel = priceCalculationModelFromJson(jsonString);

import 'dart:convert';

PriceCalculationModel priceCalculationModelFromJson(String str) =>
    PriceCalculationModel.fromJson(json.decode(str));

String priceCalculationModelToJson(PriceCalculationModel data) =>
    json.encode(data.toJson());

class PriceCalculationModel {
  final double subTotalAmount;
  final double discountAmount;
  final double taxAmount;
  final int taxPercentage;

  final int discountPercentage;
  final double orderTotal;

  PriceCalculationModel({
    required this.subTotalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.taxPercentage,
    required this.discountPercentage,
    required this.orderTotal,
  });

  factory PriceCalculationModel.fromJson(Map<String, dynamic> json) =>
      PriceCalculationModel(
        subTotalAmount: (json["sub_total_amount"] is int)
            ? json["sub_total_amount"].toDouble()
            : json["sub_total_amount"],
        discountAmount: (json["discount_amount"] is int)
            ? json["discount_amount"].toDouble()
            : json["discount_amount"],
        taxAmount: (json["tax_amount"] is int)
            ? json["tax_amount"].toDouble()
            : json["tax_amount"],
        taxPercentage: (json["tax_percentage"] is double)
            ? json["tax_percentage"].toInt()
            : json["tax_percentage"],
        discountPercentage: (json["discount_percentage"] is double)
            ? json["discount_percentage"].toInt()
            : json["discount_percentage"],
        orderTotal: (json["order_total"] is int)
            ? json["order_total"].toDouble()
            : json["order_total"],
      );

  Map<String, dynamic> toJson() => {
        "sub_total_amount": subTotalAmount,
        "discount_amount": discountAmount,
        "tax_amount": taxAmount,
        "tax_percentage": taxPercentage,
        "discount_percentage": discountPercentage,
        "order_total": orderTotal,
      };
}
