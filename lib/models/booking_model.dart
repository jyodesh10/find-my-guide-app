import 'dart:convert';

class BookingModel {
    List<Booking>? booking;

    BookingModel({
        this.booking,
    });

    factory BookingModel.fromJson(String str) => BookingModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BookingModel.fromMap(Map<String, dynamic> json) => BookingModel(
        booking: json["booking"] == null ? [] : List<Booking>.from(json["booking"]!.map((x) => Booking.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "booking": booking == null ? [] : List<dynamic>.from(booking!.map((x) => x.toMap())),
    };
}

class Booking {
    String? id;
    Tour? tour;
    String? status;
    int? participants;
    DateTime? bookedfor;
    String? user;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Booking({
        this.id,
        this.tour,
        this.status,
        this.participants,
        this.bookedfor,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Booking.fromJson(String str) => Booking.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        tour: json["tour"] == null ? null : Tour.fromMap(json["tour"]),
        status: json["status"],
        participants: json["participants"],
        bookedfor: json["bookedfor"] == null ? null : DateTime.parse(json["bookedfor"]),
        user: json["user"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "tour": tour?.toMap(),
        "status": status,
        "participants": participants,
        "bookedfor": bookedfor?.toIso8601String(),
        "user": user,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Tour {
    String? pricePer;
    String? id;
    String? title;
    Price? price;
    List<String>? image;

    Tour({
        this.pricePer,
        this.id,
        this.title,
        this.price,
        this.image,
    });

    factory Tour.fromJson(String str) => Tour.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Tour.fromMap(Map<String, dynamic> json) => Tour(
        pricePer: json["pricePer"],
        id: json["_id"],
        title: json["title"],
        price: json["price"] == null ? null : Price.fromMap(json["price"]),
        image: json["image"] == null ? [] : List<String>.from(json["image"]!.map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "pricePer": pricePer,
        "_id": id,
        "title": title,
        "price": price?.toMap(),
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
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
