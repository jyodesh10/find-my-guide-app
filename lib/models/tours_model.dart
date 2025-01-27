import 'dart:convert';

class ToursModel {
    String? id;
    Guide? guide;
    String? title;
    String? description;
    Highlights? highlights;
    String? price;
    List<String>? image;
    int? v;
    int? rating;
    List<Review>? reviews;

    ToursModel({
        this.id,
        this.guide,
        this.title,
        this.description,
        this.highlights,
        this.price,
        this.image,
        this.v,
        this.rating,
        this.reviews,
    });

    factory ToursModel.fromJson(String str) => ToursModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ToursModel.fromMap(Map<String, dynamic> json) => ToursModel(
        id: json["_id"],
        guide: json["guide"] == null ? null : Guide.fromMap(json["guide"]),
        title: json["title"],
        description: json["description"],
        highlights: json["highlights"] == null ? null : Highlights.fromMap(json["highlights"]),
        price: json["price"],
        image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
        v: json["__v"],
        rating: json["rating"],
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "guide": guide?.toMap(),
        "title": title,
        "description": description,
        "highlights": highlights?.toMap(),
        "price": price,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "__v": v,
        "rating": rating,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
    };
}

class Guide {
    String? id;
    String? firstname;
    String? lastname;

    Guide({
        this.id,
        this.firstname,
        this.lastname,
    });

    factory Guide.fromJson(String str) => Guide.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Guide.fromMap(Map<String, dynamic> json) => Guide(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
    };
}

class Highlights {
    Location? location;
    String? duration;
    List<String>? languages;
    List<String>? specializations;
    String? id;

    Highlights({
        this.location,
        this.duration,
        this.languages,
        this.specializations,
        this.id,
    });

    factory Highlights.fromJson(String str) => Highlights.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Highlights.fromMap(Map<String, dynamic> json) => Highlights(
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
        duration: json["duration"],
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
        specializations: json["specializations"] == null ? [] : List<String>.from(json["specializations"]!.map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toMap() => {
        "location": location?.toMap(),
        "duration": duration,
        "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
        "specializations": specializations == null ? [] : List<dynamic>.from(specializations!.map((x) => x)),
        "_id": id,
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

class Review {
    String? id;
    User? user;
    String? tour;
    int? rating;
    String? comment;
    DateTime? createdAt;
    int? v;

    Review({
        this.id,
        this.user,
        this.tour,
        this.rating,
        this.comment,
        this.createdAt,
        this.v,
    });

    factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Review.fromMap(Map<String, dynamic> json) => Review(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        tour: json["tour"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "user": user?.toMap(),
        "tour": tour,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
    };
}

class User {
    String? id;
    String? username;
    String? image;

    User({
        this.id,
        this.username,
        this.image,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "image": image,
    };
}
