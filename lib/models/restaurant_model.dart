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
    id: json["id"],
    name: json["nombre"],
    address: json["direccion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": name,
    "direccion": address,
  };
}