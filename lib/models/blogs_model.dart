import 'dart:convert';

class BlogsModel {
    int? page;
    int? limit;
    List<BlogData>? data;

    BlogsModel({
        this.page,
        this.limit,
        this.data,
    });

    factory BlogsModel.fromJson(String str) => BlogsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BlogsModel.fromMap(Map<String, dynamic> json) => BlogsModel(
        page: json["page"],
        limit: json["limit"],
        data: json["data"] == null ? [] : List<BlogData>.from(json["data"]!.map((x) => BlogData.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "limit": limit,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class BlogData {
    String? id;
    String? title;
    String? content;
    String? author;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    BlogData({
        this.id,
        this.title,
        this.content,
        this.author,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory BlogData.fromJson(String str) => BlogData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BlogData.fromMap(Map<String, dynamic> json) => BlogData(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        author: json["author"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "content": content,
        "author": author,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
