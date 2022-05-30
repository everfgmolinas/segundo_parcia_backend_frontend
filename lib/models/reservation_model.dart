import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/models/user_model.dart';

import 'hour_model.dart';

List<Reservation> reservationsFromJson(dynamic str) => List<Reservation>.from(str.map((x) => Reservation.fromJson(x)));

class Reservation {
  String? id,
  restaurante_id,
  cliente_id,
  mesa_id,
  cantidad,
  fecha;

  MyTable? mesa;

  Cliente? cliente;

  List<Hour>? hours;

  Reservation(
      {this.id,
      this.restaurante_id,
      this.cliente_id,
      this.mesa_id,
      this.cantidad,
      this.fecha,
      this.hours});

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    cliente_id: json["cliente_id"],
    mesa_id: json["mesa_id"],
    cantidad: json["cantidad"],
    hours: hourFromJsons(json["Horas_Reservas"]),
  );

  Map<String, dynamic> toJson() => {
    "restaurante_id": restaurante_id,
    "cliente_id": cliente_id,
    "mesa_id": mesa_id,
    "cantidad": cantidad,
    "fecha": fecha,
    //"horas": hour.map(h => h.toJson)
  };
}
