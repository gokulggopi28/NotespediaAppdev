// To parse this JSON data, do
//
//     final circularStoryModel = circularStoryModelFromJson(jsonString);

import 'dart:convert';

CircularStoryModel circularStoryModelFromJson(String str) =>
    CircularStoryModel.fromJson(json.decode(str));

String circularStoryModelToJson(CircularStoryModel data) =>
    json.encode(data.toJson());

class CircularStoryModel {
  final List<CircularStoryList> stories;

  CircularStoryModel({
    required this.stories,
  });

  factory CircularStoryModel.fromJson(Map<String, dynamic> json) =>
      CircularStoryModel(
        stories: List<CircularStoryList>.from(
            json["data"].map((x) => CircularStoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(stories.map((x) => x.toJson())),
      };
}

class CircularStoryList {
  final int id;
  final String title;
  final String image;
  final String routingUrl;

  CircularStoryList({
    required this.id,
    required this.title,
    required this.image,
    required this.routingUrl,
  });

  factory CircularStoryList.fromJson(Map<String, dynamic> json) =>
      CircularStoryList(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        routingUrl: json["routing_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "routing_url": routingUrl,
      };
}
