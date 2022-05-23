class User {
  String? id,
    identifier,
    givenName,
    lastName;

  User(
      {this.id,
        this.givenName,
        this.lastName,
        this.identifier,});

  factory User.fromJson(Map<String, dynamic> json) => User(
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