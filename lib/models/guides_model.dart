import 'dart:convert';

class GuidesModel {
    String? pricePer;
    String? id;
    String? firstname;
    String? lastname;
    String? email;
    String? password;
    Location? location;
    List<String>? languages;
    List<String>? specializations;
    int? rating;
    bool? isVerified;
    List<dynamic>? documents;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? bio;
    int? experience;
    String? facebook;
    String? website;
    String? whatsapp;
    DateTime? dob;
    String? image;
    Price? price;
    List<Review>? reviews;
    String? phone;

    GuidesModel({
        this.pricePer,
        this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.password,
        this.location,
        this.languages,
        this.specializations,
        this.rating,
        this.isVerified,
        this.documents,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.bio,
        this.experience,
        this.facebook,
        this.website,
        this.whatsapp,
        this.dob,
        this.image,
        this.price,
        this.reviews,
        this.phone,
    });

    factory GuidesModel.fromJson(String str) => GuidesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GuidesModel.fromMap(Map<String, dynamic> json) => GuidesModel(
        pricePer: json["pricePer"],
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
        specializations: json["specializations"] == null ? [] : List<String>.from(json["specializations"]!.map((x) => x)),
        rating: json["rating"],
        isVerified: json["isVerified"],
        documents: json["documents"] == null ? [] : List<dynamic>.from(json["documents"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        experience: json["experience"],
        facebook: json["facebook"],
        website: json["website"],
        whatsapp: json["whatsapp"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        image: json["image"],
        price: json["price"] == null ? null : Price.fromMap(json["price"]),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromMap(x))),
        phone: json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "pricePer": pricePer,
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "location": location?.toMap(),
        "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
        "specializations": specializations == null ? [] : List<dynamic>.from(specializations!.map((x) => x)),
        "rating": rating,
        "isVerified": isVerified,
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "bio": bio,
        "experience": experience,
        "facebook": facebook,
        "website": website,
        "whatsapp": whatsapp,
        "dob": dob?.toIso8601String(),
        "image": image,
        "price": price?.toMap(),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toMap())),
        "phone": phone,
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

class Price {
    String? numberDecimal;

    Price({
        this.numberDecimal,
    });

    factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Price.fromMap(Map<String, dynamic> json) => Price(
        numberDecimal: json["\u0024numberDecimal"],
    );

    Map<String, dynamic> toMap() => {
        "\u0024numberDecimal": numberDecimal,
    };
}

class Review {
    String? id;
    User? user;
    String? guide;
    int? rating;
    String? comment;
    DateTime? createdAt;
    int? v;

    Review({
        this.id,
        this.user,
        this.guide,
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
        guide: json["guide"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "user": user?.toMap(),
        "guide": guide,
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
