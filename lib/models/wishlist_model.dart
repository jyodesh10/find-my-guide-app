import 'dart:convert';

class WishlistModel {
    List<Wishlist>? wishlist;

    WishlistModel({
        this.wishlist,
    });

    factory WishlistModel.fromJson(String str) => WishlistModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory WishlistModel.fromMap(Map<String, dynamic> json) => WishlistModel(
        wishlist: json["wishlist"] == null ? [] : List<Wishlist>.from(json["wishlist"]!.map((x) => Wishlist.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "wishlist": wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x.toMap())),
    };
}

class Wishlist {
    String? id;
    Tour? tour;
    String? user;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Wishlist({
        this.id,
        this.tour,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Wishlist.fromJson(String str) => Wishlist.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Wishlist.fromMap(Map<String, dynamic> json) => Wishlist(
        id: json["_id"],
        tour: json["tour"] == null ? null : Tour.fromMap(json["tour"]),
        user: json["user"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "tour": tour?.toMap(),
        "user": user,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Tour {
    String? id;
    String? title;
    String? price;
    List<String>? image;

    Tour({
        this.id,
        this.title,
        this.price,
        this.image,
    });

    factory Tour.fromJson(String str) => Tour.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tour.fromMap(Map<String, dynamic> json) => Tour(
        id: json["_id"],
        title: json["title"],
        price: json["price"],
        image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "price": price,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
    };
}
