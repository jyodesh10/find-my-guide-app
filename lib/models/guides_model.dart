import 'dart:convert';

class GuidesModel {
    String id;
    String firstname;
    String lastname;
    String email;
    String password;
    Location location;
    List<dynamic> languages;
    List<dynamic> specializations;
    List<dynamic> reviews;
    int rating;
    bool isVerified;
    List<dynamic> documents;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String bio;
    int experience;
    String facebook;
    String website;
    String whatsapp;
    DateTime dob;
    String image;

    GuidesModel({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.email,
        required this.password,
        required this.location,
        required this.languages,
        required this.specializations,
        required this.reviews,
        required this.rating,
        required this.isVerified,
        required this.documents,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.bio,
        required this.experience,
        required this.facebook,
        required this.website,
        required this.whatsapp,
        required this.dob,
        required this.image,
    });

    factory GuidesModel.fromJson(String str) => GuidesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GuidesModel.fromMap(Map<String, dynamic> json) => GuidesModel(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        location: Location.fromMap(json["location"]),
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
        specializations: List<dynamic>.from(json["specializations"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        rating: json["rating"],
        isVerified: json["isVerified"],
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        experience: json["experience"],
        facebook: json["facebook"],
        website: json["website"],
        whatsapp: json["whatsapp"],
        dob: DateTime.parse(json["dob"]),
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "location": location.toMap(),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "specializations": List<dynamic>.from(specializations.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "rating": rating,
        "isVerified": isVerified,
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "experience": experience,
        "facebook": facebook,
        "website": website,
        "whatsapp": whatsapp,
        "dob": dob.toIso8601String(),
        "image": image,
    };
}

class Location {
    String country;
    String region;
    String city;

    Location({
        required this.country,
        required this.region,
        required this.city,
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
