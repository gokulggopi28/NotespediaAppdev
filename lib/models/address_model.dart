class Address {
  final int id;
  final String? addressLine1;
  final String? addressLine2;
  final String? addressType;
  final int userId;
  final String country;
  final String state;
  final String city;
  final int pinCode;
  final String contactPersonName;
  final String contactPersonPhone;
  final int isDefault;

  Address({
    required this.id,
    this.addressLine1,
    this.addressLine2,
    this.addressType,
    required this.userId,
    required this.country,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.contactPersonName,
    required this.contactPersonPhone,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'] ?? '0') ?? 0,
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      addressType: json['address_type'],
      userId: json['user_id'] is int
          ? json['user_id']
          : int.tryParse(json['user_id'] ?? '0') ?? 0,
      country: json['country'],
      state: json['state'],
      city: json['city'],
      pinCode: json['pin_code'] is int
          ? json['pin_code']
          : int.tryParse(json['pin_code'] ?? '0') ?? 0,
      contactPersonName: json['contact_person_name'],
      contactPersonPhone: json['contact_person_phone'],
      isDefault: json['is_default'] is int
          ? json['is_default']
          : int.tryParse(json['is_default'] ?? '0') ?? 0,
    );
  }

  Object? toJson() {}
}
