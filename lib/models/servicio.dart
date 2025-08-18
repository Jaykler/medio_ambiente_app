class Servicio {
  final int id;
  final String nombre;
  final String descripcion;
  final String icono;

  Servicio({required this.id, required this.nombre, required this.descripcion, required this.icono});

  factory Servicio.fromJson(Map<String, dynamic> j) => Servicio(
    id: (j['id'] ?? 0) as int,
    nombre: (j['nombre'] ?? '') as String,
    descripcion: (j['descripcion'] ?? '') as String,
    icono: (j['icono'] ?? '') as String,
  );
}
