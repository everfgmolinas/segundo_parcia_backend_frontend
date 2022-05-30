List<Hour> hourFromJsons(dynamic str) => List<Hour>.from(str.map((x) => Hour.fromJson(x)));

class Hour {
  String? id,
  reserva_id,
  hora_inicio,
  hora_fin,
      cantidad,
      fecha;


  Hour(
      {this.id,
        this.reserva_id,
        this.hora_inicio,
        this.hora_fin,
        this.cantidad,
        this.fecha});

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    id: json["id"],
    reserva_id: json["reserva_id"],
    hora_inicio: json["hora_inicio"],
    hora_fin: json["hora_fin"],
    fecha: json["fecha"],
    //hours: json["Horas_Reservas"]?
  );

  Map<String, dynamic> toJson() => {
    "hora_inicio": hora_inicio,
    "hora_fin": hora_fin,
  };
}
