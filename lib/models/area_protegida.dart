//Modificado por libe 
class AreaProtegida {
  final String id;
  final String nombre;
  final String tipo;
  final String descripcion;
  final String ubicacion;
  final String superficie;
  final String imagen;
  final double latitud;
  final double longitud;

  // Getters para compatibilidad con el mapa existente
  double get lat => latitud;
  double get lng => longitud;

  AreaProtegida({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.ubicacion,
    required this.superficie,
    required this.imagen,
    required this.latitud,
    required this.longitud,
  });

  factory AreaProtegida.fromJson(Map<String, dynamic> json) {
    return AreaProtegida(
      id: json['id']?.toString() ?? '',
      nombre: json['nombre']?.toString() ?? '',
      tipo: json['tipo']?.toString() ?? '',
      descripcion: json['descripcion']?.toString() ?? '',
      ubicacion: json['ubicacion']?.toString() ?? '',
      superficie: json['superficie']?.toString() ?? '',
      imagen: json['imagen']?.toString() ?? '',
      latitud: double.tryParse(json['latitud']?.toString() ?? '0') ?? 0.0,
      longitud: double.tryParse(json['longitud']?.toString() ?? '0') ?? 0.0,
    );
  }
}