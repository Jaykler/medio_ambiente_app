class Reporte {
  final String? id;
  final String titulo;
  final String descripcion;
  final String? fotoBase64;
  final double lat;
  final double lng;
  final DateTime? fecha;

  Reporte({
    this.id,
    required this.titulo,
    required this.descripcion,
    this.fotoBase64,
    required this.lat,
    required this.lng,
    this.fecha,
  });

  factory Reporte.fromJson(Map<String, dynamic> j) => Reporte(
    id: (j['id'] as num?)?.toString(),
    titulo: (j['titulo'] ?? '') as String,
    descripcion: (j['descripcion'] ?? '') as String,
    fotoBase64: j['foto'] as String?,
    lat: double.tryParse('${j['lat'] ?? j['latitud'] ?? 0}') ?? 0,
    lng: double.tryParse('${j['lng'] ?? j['longitud'] ?? 0}') ?? 0,
    fecha: j['fecha'] != null ? DateTime.tryParse(j['fecha'].toString()) : null,
  );

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descripcion': descripcion,
    'foto': fotoBase64,
    'latitud': lat,
    'longitud': lng,
  };
}
