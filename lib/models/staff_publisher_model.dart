// To parse this JSON data, do
//
//     final bookPublishersModel = bookPublishersModelFromJson(jsonString);

import 'dart:convert';

StaffPublisherModel bookPublishersModelFromJson(String str) =>
    StaffPublisherModel.fromJson(json.decode(str));

String bookPublishersModelToJson(StaffPublisherModel data) =>
    json.encode(data.toJson());

class StaffPublisherModel {
  final List<StaffPublishersList> staffPublisher;

  StaffPublisherModel({
    required this.staffPublisher,
  });

  factory StaffPublisherModel.fromJson(Map<String, dynamic> json) =>
      StaffPublisherModel(
        staffPublisher: List<StaffPublishersList>.from(
            json["data"].map((x) => StaffPublishersList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(staffPublisher.map((x) => x.toJson())),
      };
}

class StaffPublishersList {
  final int staffId;
  final String staffName;
  final String staffImage;
  final String staffDesignation;

  StaffPublishersList({
    required this.staffId,
    required this.staffName,
    required this.staffImage,
    required this.staffDesignation,
  });

  factory StaffPublishersList.fromJson(Map<String, dynamic> json) =>
      StaffPublishersList(
        staffId: json["id"],
        staffName: json["name"],
        staffImage: json["profile_image"],
        staffDesignation: json["staff_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": staffId,
        "name": staffName,
        "profile_image": staffImage,
        "staff_category": staffDesignation,
      };
}
