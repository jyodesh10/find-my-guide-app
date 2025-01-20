import 'dart:convert';

class GuidesModel {
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
    String? price;
    List<String>? reviews;

    GuidesModel({
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
    });

    factory GuidesModel.fromJson(String str) => GuidesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GuidesModel.fromMap(Map<String, dynamic> json) => GuidesModel(
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
        price: json["price"],
        reviews: json["reviews"] == null ? [] : List<String>.from(json["reviews"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
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
        "price": price,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
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
