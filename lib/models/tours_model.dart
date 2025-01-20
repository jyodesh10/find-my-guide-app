class ToursModel {
  String? sId;
  String? guide;
  String? title;
  String? description;
  Highlights? highlights;
  String? price;
  List<String>? image;
  int? iV;

  ToursModel(
      {this.sId,
      this.guide,
      this.title,
      this.description,
      this.highlights,
      this.price,
      this.image,
      this.iV});

  ToursModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    guide = json['guide'];
    title = json['title'];
    description = json['description'];
    highlights = json['highlights'] != null
        ? Highlights.fromJson(json['highlights'])
        : null;
    price = json['price'];
    image = json['image'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['guide'] = guide;
    data['title'] = title;
    data['description'] = description;
    if (highlights != null) {
      data['highlights'] = highlights!.toJson();
    }
    data['price'] = price;
    data['image'] = image;
    data['__v'] = iV;
    return data;
  }
}

class Highlights {
  Location? location;
  String? duration;
  List<String>? languages;
  List<String>? specializations;
  String? sId;

  Highlights(
      {this.location,
      this.duration,
      this.languages,
      this.specializations,
      this.sId});

  Highlights.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    duration = json['duration'];
    languages = json['languages'].cast<String>();
    specializations = json['specializations'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['duration'] = duration;
    data['languages'] = languages;
    data['specializations'] = specializations;
    data['_id'] = sId;
    return data;
  }
}

class Location {
  String? country;
  String? region;
  String? city;

  Location({this.country, this.region, this.city});

  Location.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    region = json['region'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['region'] = region;
    data['city'] = city;
    return data;
  }
}