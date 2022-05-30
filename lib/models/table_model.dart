List<MyTable> tableFromJson(dynamic str) => List<MyTable>.from(str.map((x) => MyTable.fromJson(x)));

class MyTable {
  String? nombre,
      id,
      estado;

  int? restaurante_id,
      posicion_x,
      posicion_y,
      planta,
      capacidad;


  MyTable(
      {this.id,
        this.nombre,
        this.restaurante_id,
        this.capacidad,
        this.estado,
        this.planta,
        this.posicion_x,
        this.posicion_y});

  factory MyTable.fromJson(Map<String, dynamic> json) => MyTable(
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