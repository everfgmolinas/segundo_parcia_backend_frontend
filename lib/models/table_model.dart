List<Table> userVaccinationFromJson(dynamic str) => List<Table>.from(str.map((x) => Restaurant.fromJson(x)));

class Table {
  String? nombre,
      restaurante_id,
      posicion_x,
      posicion_y,
      id,
      planta,
      capacidad,
      estado;

  Table(
      {this.id,
        this.nombre,
        this.restaurante_id,
        this.capacidad,
        this.estado,
        this.planta,
        this.posicion_x,
        this.posicion_y});

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    id: json["id"],
    nombre: json["nombre"],
    restaurante_id: json["restaurante_id"],
    capacidad: json["capacidad"],
    estado: json["estado"],
    planta: json["planta"],
    posicion_x: json["posicion_x"],
    posicion_y: json["posicion_y"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "restaurante_id": restaurante_id,
    "capacidad": capacidad,
    "estado": estado,
    "planta": planta,
    "posicion_x": posicion_x,
    "posicion_y": posicion_y
  };
}