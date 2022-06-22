import 'package:segundo_parcia_backend/models/producto_model.dart';

List<Detalle> detailFromJson(dynamic str) => List<Detalle>.from(str.map((x) => Detalle.fromJson(x)));

class Detalle {
  String?
      id;

  int?
      cantidad;

  Producto?
    producto;

  Detalle(
      {this.id,
        this.cantidad,
        this.producto});

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
    id: json["id"],
    cantidad: json["cantidad"],
    producto: Producto.fromJson(json["Producto"]),
  );

  Map<String, dynamic> toJson() => {
    "cantidad": cantidad
  };
}
