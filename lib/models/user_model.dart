import 'dart:convert';

class UserModel {
    String? id;
    String? username;
    String? email;
    String? image;
    DateTime? dob;
    int? mobileNo;
    Location? location;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    UserModel({
        this.id,
        this.username,
        this.email,
        this.image,
        this.dob,
        this.mobileNo,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        image: json["image"],
        dob: json["dob"]== null ? null : DateTime.parse(json["dob"]),
        mobileNo: json["mobile_no"],
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "email": email,
        "image": image,
        "dob": dob?.toIso8601String(),
        "mobile_no": mobileNo,
        "location": location?.toMap(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Location {
    String? country;
    String? region;
    String? city;

    Location({
        this.country,
        this.region,
        this.city,
    });

    factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Location.fromMap(Map<String, dynamic> json) => Location(
        country: json["country"],
        region: json["region"],
        city: json["city"],
    );

    Map<String, dynamic> toMap() => {
        "country": country,
        "region": region,
        "city": city,
    };
}
