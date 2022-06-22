List<Cliente> clientesFromJson(dynamic str) => List<Cliente>.from(str.map((x) => Cliente.fromJson(x)));

class Cliente {
  String? id,
    identifier,
    givenName,
    lastName;

  Cliente(
      {this.id,
        this.givenName,
        this.lastName,
        this.identifier,});

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    id: json["id"],
    identifier: json["cedula"],
    lastName: json["apellido"],
    givenName: json["nombre"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "givenName": givenName,
    "lastName": lastName,
    "identifier": identifier,
  };
}