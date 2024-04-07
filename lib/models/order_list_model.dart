// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  final List<OrderList> orderListData;

  OrderListModel({
    required this.orderListData,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        orderListData: List<OrderList>.from(
            json["data"].map((x) => OrderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(orderListData.map((x) => x.toJson())),
      };
}

class OrderList {
  final int orderId;
  final int userId;
  final int paymentMethodId;
  final int paymentStatusId;
  final int deliveryStatusId;
  final int orderStatus;
  final int addressId;
  final int couponId;
  final String subTotalAmount;
  final String discountAmount;
  final String taxAmount;
  final String totalAmount;
  final String createdOn;
  final String deliveredOn;
  final String orderNumber;
  final String shippingId;
  final bool isDeleted;
  final String bookName;
  final String bookCoverImage;
  final String orderStatusText;
  final String orderStatusDate;
  final String orderDetailsUrl;

  OrderList({
    required this.orderId,
    required this.userId,
    required this.paymentMethodId,
    required this.paymentStatusId,
    required this.deliveryStatusId,
    required this.orderStatus,
    required this.addressId,
    required this.couponId,
    required this.subTotalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.createdOn,
    required this.deliveredOn,
    required this.orderNumber,
    required this.shippingId,
    required this.isDeleted,
    required this.bookName,
    required this.bookCoverImage,
    required this.orderStatusText,
    required this.orderStatusDate,
    required this.orderDetailsUrl,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        orderId: int.tryParse(json["id"].toString()) ?? 0,
        userId: int.tryParse(json["user_id"].toString()) ?? 0,
        paymentMethodId:
            int.tryParse(json["payment_method_id"].toString()) ?? 0,
        paymentStatusId:
            int.tryParse(json["payment_status_id"].toString()) ?? 0,
        deliveryStatusId:
            int.tryParse(json["delivery_status_id"].toString()) ?? 0,
        orderStatus: int.tryParse(json["order_status"].toString()) ?? 0,
        addressId: int.tryParse(json["address_id"].toString()) ?? 0,
        couponId: int.tryParse(json["coupon_id"].toString()) ?? 0,
        subTotalAmount: json["sub_total_amount"]?.toString() ?? '',
        discountAmount: json["discount_amount"]?.toString() ?? '',
        taxAmount: json["tax_amount"]?.toString() ?? '',
        totalAmount: json["total_amount"]?.toString() ?? '',
        createdOn: json["created_on"]?.toString() ?? '',
        deliveredOn: json["delivered_on"]?.toString() ?? '',
        orderNumber: json["order_number"]?.toString() ?? '',
        shippingId: json["shipping_id"]?.toString() ?? '',
        isDeleted: json["is_deleted"] == 1,
        bookName: json["book_name"]?.toString() ?? '',
        bookCoverImage: json["book_cover_image"]?.toString() ?? '',
        orderStatusText: json["order_status_text"]?.toString() ?? '',
        orderStatusDate: json["order_status_date"]?.toString() ?? '',
        orderDetailsUrl: json["order_details_url"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": orderId,
        "user_id": userId,
        "payment_method_id": paymentMethodId,
        "payment_status_id": paymentStatusId,
        "delivery_status_id": deliveryStatusId,
        "order_status": orderStatus,
        "address_id": addressId,
        "coupon_id": couponId,
        "sub_total_amount": subTotalAmount,
        "discount_amount": discountAmount,
        "tax_amount": taxAmount,
        "total_amount": totalAmount,
        "created_on": createdOn,
        "delivered_on": deliveredOn,
        "order_number": orderNumber,
        "shipping_id": shippingId,
        "is_deleted": isDeleted ? 1 : 0,
        "book_name": bookName,
        "book_cover_image": bookCoverImage,
        "order_status_text": orderStatusText,
        "order_status_date": orderStatusDate,
        "order_details_url": orderDetailsUrl,
      };
}
