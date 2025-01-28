import 'dart:convert';

class MessageModel {
    String? id;
    String? user;
    Guide? guide;
    List<Message>? messages;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    MessageModel({
        this.id,
        this.user,
        this.guide,
        this.messages,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory MessageModel.fromJson(String str) => MessageModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        id: json["_id"],
        user: json["user"],
        guide: json["guide"] == null ? null : Guide.fromMap(json["guide"]),
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromMap(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "user": user,
        "guide": guide?.toMap(),
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toMap())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Guide {
    String? id;
    String? firstname;
    String? lastname;
    String? image;

    Guide({
        this.id,
        this.firstname,
        this.lastname,
        this.image,
    });

    factory Guide.fromJson(String str) => Guide.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Guide.fromMap(Map<String, dynamic> json) => Guide(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "image": image,
    };
}

class Message {
    String? content;
    String? senderId;
    DateTime? createdAt;
    String? id;

    Message({
        this.content,
        this.senderId,
        this.createdAt,
        this.id,
    });

    factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        content: json["content"],
        senderId: json["senderID"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        id: json["_id"],
    );

    Map<String, dynamic> toMap() => {
        "content": content,
        "senderID": senderId,
        "createdAt": createdAt?.toIso8601String(),
        "_id": id,
    };
}
