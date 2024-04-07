// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.data,
  });

  final Data data;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.mobileNumber,
    this.profileImage,
    required this.userId,
    this.courseId, // Changed to nullable
    this.isVerified, // Changed to nullable
    required this.college,
    required this.signupMethod,
    required this.courseName,
    this.email,
    required this.name,
    this.notes, // Changed to nullable
    this.followers, // Changed to nullable
    this.following, // Changed to nullable
  });

  final int id;
  final String mobileNumber;
  final String? profileImage;
  final int userId;
  final int? courseId; // Nullable
  final int? isVerified; // Nullable
  final String? college;
  final String signupMethod;
  final String courseName;
  final String? email;
  final String name;
  final int? notes; // Nullable
  final int? followers; // Nullable
  final int? following; // Nullable

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        mobileNumber: json["mobile_number"],
        profileImage: json["profile_image"],
        userId: json["user_id"],
        courseId: json["course_id"] != null ? json["course_id"] : null,
        isVerified: json["is_verified"] != null ? json["is_verified"] : null,
        college: json["college"] != null ? json["college"] : " ",
        signupMethod: json["signup_method"],
        courseName: json["course_name"],
        email: json["email"],
        name: json["name"],
        notes: json["notes"] != null ? json["notes"] : null,
        followers: json["followers"] != null ? json["followers"] : null,
        following: json["following"] != null ? json["following"] : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_number": mobileNumber,
        "profile_image": profileImage,
        "user_id": userId,
        "course_id": courseId,
        "is_verified": isVerified,
        "college": college,
        "signup_method": signupMethod,
        "course_name": courseName,
        "email": email,
        "name": name,
        "notes": notes,
        "followers": followers,
        "following": following,
      };
}
