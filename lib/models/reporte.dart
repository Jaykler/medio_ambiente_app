class Reporte {
  final int? id;
  final String titulo;
  final String descripcion;
  final String? fotoBase64;
  final double lat;
  final double lng;

  Reporte({this.id, required this.titulo, required this.descripcion, this.fotoBase64, required this.lat, required this.lng});

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descripcion': descripcion,
    'foto': fotoBase64,
    'latitud': lat,
    'longitud': lng,
  };
}