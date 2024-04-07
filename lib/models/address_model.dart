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
  final int isDefault; // Added field

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
    required this.isDefault, // Initialize in constructor
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      addressType: json['address_type'],
      userId: json['user_id'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      pinCode: json['pin_code'],
      contactPersonName: json['contact_person_name'],
      contactPersonPhone: json['contact_person_phone'],
      isDefault: json['is_default'], // Assign from JSON
    );
  }
}
