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
    identifier: json["identifier"],
    lastName: json["lastName"],
    givenName: json["givenName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "givenName": givenName,
    "lastName": lastName,
    "identifier": identifier,
  };
}