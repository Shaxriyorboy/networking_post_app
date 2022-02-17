// To parse this JSON data, do
//
//     final uaer = uaerFromJson(jsonString);

import 'dart:convert';

List<Post> userFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String userToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  String? userId;
  String? id;
  String? title;
  String? body;

  Post.fromJson(Map<String, dynamic> json)
    :title = json["title"],
    body = json["body"],
    userId = json["userId"],
    id = json["id"];

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "userId": userId,
    "id": id,
  };
}
