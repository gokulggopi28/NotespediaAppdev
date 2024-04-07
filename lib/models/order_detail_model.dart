import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  OrderDetailModel({
    required this.listData,
  });

  final OrderDetailList listData;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        listData: OrderDetailList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": listData.toJson(),
      };
}

class OrderDetailList {
  OrderDetailList({
    required this.id,
    required this.userId,
    required this.paymentMethodId,
    required this.paymentStatusId,
    required this.deliveryStatusId,
    required this.orderStatus,
    required this.addressId,
    required this.couponId,
    required this.subTotalAmount,
    required this.discountAmount,
    required this.shippingAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.createdOn,
    this.deliveredOn,
    required this.orderNumber,
    this.shippingId,
    this.paymentId,
    this.orderSource,
    this.customerIp,
    this.shopifyOrderId,
    this.shopifyCheckoutId,
    this.shopifyCheckoutToken,
    required this.deliveryStatus,
    required this.isDeleted,
    required this.hasSeen,
    required this.orderItems,
    required this.shippingAddress,
  });

  final int id;
  final int userId;
  final int paymentMethodId;
  final int paymentStatusId;
  final int deliveryStatusId;
  final int orderStatus;
  final int addressId;
  final int couponId;
  final String subTotalAmount;
  final String discountAmount;
  final String shippingAmount;
  final String taxAmount;
  final String totalAmount;
  final String createdOn;
  final String? deliveredOn;
  final String? orderNumber;
  final String? shippingId;
  final String? paymentId;
  final String? orderSource;
  final String? customerIp;
  final String? shopifyOrderId;
  final String? shopifyCheckoutId;
  final String? shopifyCheckoutToken;
  final String deliveryStatus;
  final bool isDeleted;
  final int hasSeen;
  final List<OrderItem> orderItems;
  final ShippingAddress shippingAddress;

  factory OrderDetailList.fromJson(Map<String, dynamic> json) =>
      OrderDetailList(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        paymentMethodId: json["payment_method_id"] ?? 0,
        paymentStatusId: json["payment_status_id"] ?? 0,
        deliveryStatusId: json["delivery_status_id"] ?? 0,
        orderStatus: json["order_status"] ?? 0,
        addressId: json["address_id"] ?? 0,
        couponId: json["coupon_id"] ?? 0,
        subTotalAmount: json["sub_total_amount"]?.toString() ?? '0',
        discountAmount: json["discount_amount"]?.toString() ?? '0',
        shippingAmount: json["shipping_amount"]?.toString() ?? '0',
        taxAmount: json["tax_amount"]?.toString() ?? '0',
        totalAmount: json["total_amount"]?.toString() ?? '0',
        createdOn: json["created_on"] ?? '',
        deliveredOn: json["delivered_on"],
        orderNumber: json["order_number"],
        shippingId: json["shipping_id"],
        paymentId: json["payment_id"],
        orderSource: json["order_source"],
        customerIp: json["customer_ip"],
        shopifyOrderId: json["shopify_order_id"],
        shopifyCheckoutId: json["shopify_checkout_id"],
        shopifyCheckoutToken: json["shopify_checkout_token"],
        deliveryStatus: json["delivery_status"] ?? '',
        isDeleted: json["is_deleted"] ?? false,
        hasSeen: json["has_seen"] ?? 0,
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x ?? {}))),
        shippingAddress:
            ShippingAddress.fromJson(json["shipping_address"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "payment_method_id": paymentMethodId,
        "payment_status_id": paymentStatusId,
        "delivery_status_id": deliveryStatusId,
        "order_status": orderStatus,
        "address_id": addressId,
        "coupon_id": couponId,
        "sub_total_amount": subTotalAmount,
        "discount_amount": discountAmount,
        "shipping_amount": shippingAmount,
        "tax_amount": taxAmount,
        "total_amount": totalAmount,
        "created_on": createdOn,
        "delivered_on": deliveredOn,
        "order_number": orderNumber,
        "shipping_id": shippingId,
        "payment_id": paymentId,
        "order_source": orderSource,
        "customer_ip": customerIp,
        "shopify_order_id": shopifyOrderId,
        "shopify_checkout_id": shopifyCheckoutId,
        "shopify_checkout_token": shopifyCheckoutToken,
        "delivery_status": deliveryStatus,
        "is_deleted": isDeleted,
        "has_seen": hasSeen,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "shipping_address": shippingAddress.toJson(),
      };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.orderId,
    required this.bookId,
    required this.bookType,
    required this.quantity,
    required this.bookSubTotalAmount,
    required this.authorName,
    required this.bookName,
    required this.bookCoverImage,
  });

  final int id;
  final int orderId;
  final int bookId;
  final int bookType;
  final int quantity;
  final String bookSubTotalAmount;
  final String authorName;
  final String bookName;
  final String bookCoverImage;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"] ?? 0,
        orderId: json["order_id"] ?? 0,
        bookId: json["book_id"] ?? 0,
        bookType: json["book_type"] ?? 0,
        quantity: json["quantity"] ?? 0,
        bookSubTotalAmount: json["book_sub_total_amount"]?.toString() ?? '0',
        authorName: json["author_name"] ?? '',
        bookName: json["book_name"] ?? '',
        bookCoverImage: json["book_cover_image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "book_id": bookId,
        "book_type": bookType,
        "quantity": quantity,
        "book_sub_total_amount": bookSubTotalAmount,
        "author_name": authorName,
        "book_name": bookName,
        "book_cover_image": bookCoverImage,
      };
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.contactPersonName,
    required this.contactPersonPhone,
    required this.addressLine1,
    required this.addressLine2,
    required this.addressType,
  });

  final int id;
  final int orderId;
  final int userId;
  final String country;
  final String state;
  final String city;
  final int pinCode;
  final String contactPersonName;
  final String contactPersonPhone;
  final String addressLine1;
  final String addressLine2;
  final String addressType;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"] ?? 0,
        orderId: json["order_id"] ?? 0,
        userId: json["user_id"] ?? 0,
        country: json["country"] ?? '',
        state: json["state"] ?? '',
        city: json["city"] ?? '',
        pinCode: json["pin_code"] ?? 0,
        contactPersonName: json["contact_person_name"] ?? '',
        contactPersonPhone: json["contact_person_phone"] ?? '',
        addressLine1: json["address_line_1"] ?? '',
        addressLine2: json["address_line_2"] ?? '',
        addressType: json["address_type"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "country": country,
        "state": state,
        "city": city,
        "pin_code": pinCode,
        "contact_person_name": contactPersonName,
        "contact_person_phone": contactPersonPhone,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "address_type": addressType,
      };
}
