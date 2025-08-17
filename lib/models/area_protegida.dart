class AreaProtegida {
  final int id;
  final String nombre;
  final String descripcion;
  final double lat;
  final double lng;

  AreaProtegida({required this.id, required this.nombre, required this.descripcion, required this.lat, required this.lng});

  factory AreaProtegida.fromJson(Map<String, dynamic> j) => AreaProtegida(
    id: (j['id'] ?? 0) as int,
    nombre: (j['nombre'] ?? '') as String,
    descripcion: (j['descripcion'] ?? '') as String,
    lat: double.tryParse('${j['lat'] ?? j['latitude'] ?? 0}') ?? 0,
    lng: double.tryParse('${j['lng'] ?? j['longitude'] ?? 0}') ?? 0,
  );
}