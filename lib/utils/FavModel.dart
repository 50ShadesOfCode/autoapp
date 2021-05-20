import 'dart:io';
import 'dart:convert';

FavModel favmodelFromJson(String str) {
  final data = json.decode(str);
  return FavModel.fromMap(data);
}

String favmodelToJson(FavModel data) {
  final jsData = data.toMap();
  return json.encode(jsData);
}

class FavModel {
  String url;

  FavModel({
    required this.url,
  });

  factory FavModel.fromMap(Map<String, dynamic> json) => new FavModel(
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
      };
}
