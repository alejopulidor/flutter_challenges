import 'dart:convert';

List<Boat> boatFromJson(String str) =>
    List<Boat>.from(json.decode(str).map((x) => Boat.fromJson(x)));

String boatToJson(List<Boat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Boat {
  Boat({
    this.name,
    this.by,
    this.description,
    this.image,
    this.specs,
  });

  String name;
  String by;
  String description;
  String image;
  Specs specs;

  factory Boat.fromJson(Map<String, dynamic> json) => Boat(
        name: json["name"],
        by: json["by"],
        description: json["description"],
        image: json["image"],
        specs: Specs.fromJson(json["specs"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "by": by,
        "description": description,
        "image": image,
        "specs": specs.toJson(),
      };
}

class Specs {
  Specs({
    this.length,
    this.beam,
    this.weigth,
    this.fuelCapacity,
  });

  String length;
  String beam;
  int weigth;
  int fuelCapacity;

  factory Specs.fromJson(Map<String, dynamic> json) => Specs(
        length: json["length"],
        beam: json["beam"],
        weigth: json["weigth"],
        fuelCapacity: json["fuel_capacity"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "beam": beam,
        "weigth": weigth,
        "fuel_capacity": fuelCapacity,
      };
}
