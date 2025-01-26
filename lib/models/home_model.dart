import 'dart:convert';

class HomeModel {
    String? id;
    List<RecommendedTour>? recommendedTours;
    List<Blog>? blogs;
    List<GuidesNearby>? guidesNearby;
    int? v;

    HomeModel({
        this.id,
        this.recommendedTours,
        this.blogs,
        this.guidesNearby,
        this.v,
    });

    factory HomeModel.fromJson(String str) => HomeModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HomeModel.fromMap(Map<String, dynamic> json) => HomeModel(
        id: json["_id"],
        recommendedTours: json["recommended_tours"] == null ? [] : List<RecommendedTour>.from(json["recommended_tours"]!.map((x) => RecommendedTour.fromMap(x))),
        blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromMap(x))),
        guidesNearby: json["guides_nearby"] == null ? [] : List<GuidesNearby>.from(json["guides_nearby"]!.map((x) => GuidesNearby.fromMap(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "recommended_tours": recommendedTours == null ? [] : List<dynamic>.from(recommendedTours!.map((x) => x.toMap())),
        "blogs": blogs == null ? [] : List<dynamic>.from(blogs!.map((x) => x.toMap())),
        "guides_nearby": guidesNearby == null ? [] : List<dynamic>.from(guidesNearby!.map((x) => x.toMap())),
        "__v": v,
    };
}

class Blog {
    String? id;
    String? title;
    String? content;
    String? image;
    DateTime? createdAt;


    Blog({
        this.id,
        this.title,
        this.content,
        this.image,
        this.createdAt
    });

    factory Blog.fromJson(String str) => Blog.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Blog.fromMap(Map<String, dynamic> json) => Blog(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "content": content,
        "image": image,
        "createdAt": createdAt?.toIso8601String()
    };
}

class GuidesNearby {
    String? id;
    String? firstname;
    String? lastname;
    Location? location;
    int? rating;
    String? image;
    String? price;
    bool? isVerified;

    GuidesNearby({
        this.id,
        this.firstname,
        this.lastname,
        this.location,
        this.rating,
        this.image,
        this.price,
        this.isVerified
    });

    factory GuidesNearby.fromJson(String str) => GuidesNearby.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GuidesNearby.fromMap(Map<String, dynamic> json) => GuidesNearby(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
        rating: json["rating"],
        image: json["image"],
        price: json["price"],
        isVerified: json["isVerified"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "location": location?.toMap(),
        "rating": rating,
        "image": image,
        "price": price,
        "isVerified": isVerified,
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

class RecommendedTour {
    String? id;
    String? title;
    Highlights? highlights;
    String? price;
    List<String>? image;

    RecommendedTour({
        this.id,
        this.title,
        this.highlights,
        this.price,
        this.image,
    });

    factory RecommendedTour.fromJson(String str) => RecommendedTour.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RecommendedTour.fromMap(Map<String, dynamic> json) => RecommendedTour(
        id: json["_id"],
        title: json["title"],
        highlights: json["highlights"] == null ? null : Highlights.fromMap(json["highlights"]),
        price: json["price"],
        image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "highlights": highlights?.toMap(),
        "price": price,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
    };
}

class Highlights {
    String? duration;

    Highlights({
        this.duration,
    });

    factory Highlights.fromJson(String str) => Highlights.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Highlights.fromMap(Map<String, dynamic> json) => Highlights(
        duration: json["duration"],
    );

    Map<String, dynamic> toMap() => {
        "duration": duration,
    };
}
