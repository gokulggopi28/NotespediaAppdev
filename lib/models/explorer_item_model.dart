// To parse this JSON data, do
//
//     final bookExplorerModel = bookExplorerModelFromJson(jsonString);

import 'dart:convert';

ExplorerItemModel bookExplorerModelFromJson(String str) =>
    ExplorerItemModel.fromJson(json.decode(str));

String bookExplorerModelToJson(ExplorerItemModel data) =>
    json.encode(data.toJson());

class ExplorerItemModel {
  final List<ExplorerItemList> explorerItem;

  ExplorerItemModel({
    required this.explorerItem,
  });

  factory ExplorerItemModel.fromJson(Map<String, dynamic> json) =>
      ExplorerItemModel(
        explorerItem: List<ExplorerItemList>.from(
            json["data"].map((x) => ExplorerItemList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(explorerItem.map((x) => x.toJson())),
      };
}

class ExplorerItemList {
  final int explorerId;
  final String explorerName;
  final String explorerImg;

  ExplorerItemList({
    required this.explorerId,
    required this.explorerName,
    required this.explorerImg,
  });

  factory ExplorerItemList.fromJson(Map<String, dynamic> json) =>
      ExplorerItemList(
        explorerId: json["id"],
        explorerName: json["name"],
        explorerImg: json["item_icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": explorerId,
        "name": explorerName,
        "item_icon": explorerImg,
      };
}
