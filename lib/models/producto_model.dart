List<Producto> productFromJson(dynamic str) => List<Producto>.from(str.map((x) => Producto.fromJson(x)));

class Producto {
  String?
      id,
      nombre;

  int? categoria_id,
      precio;


  Producto(
      {this.id,
        this.nombre,
        this.categoria_id,
        this.precio,});

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    id: json["id"],
    nombre: json["nombre"],
    categoria_id: json["categoria_id"],
    precio: json["precio"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "categoria_id": categoria_id,
    "precio": precio,
  };
}
