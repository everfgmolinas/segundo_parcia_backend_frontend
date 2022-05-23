List<Restaurant> userVaccinationFromJson(dynamic str) => List<Restaurant>.from(str.map((x) => Restaurant.fromJson(x)));

class Restaurant {
  String? id,
      name,
      address;

  Restaurant(
      {this.id,
        this.name,
        this.address,});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["is"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}