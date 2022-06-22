List<Consumes> consumesFromJson(dynamic str) => List<Consumes>.from(str.map((x) => Consumes.fromJson(x)));

class Consumes {
  String? horafecha_creacion,
      id,
      estado,
      horafecha_cierre;

  int? id_cliente,
      id_mesa,
      total;


  Consumes(
      {this.id,
        this.horafecha_creacion,
        this.id_cliente,
        this.estado,
        this.id_mesa,
        this.horafecha_cierre,
        this.total});

  factory Consumes.fromJson(Map<String, dynamic> json) => Consumes(
    id: json["id"],
    horafecha_creacion: json["horafecha_creacion"],
    id_cliente: json["id_cliente"],
    horafecha_cierre: json["horafecha_cierre"],
    estado: json["estado"],
    id_mesa: json["id_mesa"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "horafecha_creacion": horafecha_creacion,
    "id_cliente": id_cliente,
    "horafecha_cierre": horafecha_cierre,
    "estado": estado,
    "id_mesa": id_mesa,
    "total": total
  };
}
