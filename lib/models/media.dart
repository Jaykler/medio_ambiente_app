class Medida {
  final String id;
  final String titulo;
  final String descripcion;
  final String categoria;
  final String icono;

  Medida({required this.id, required this.titulo, required this.descripcion, required this.categoria, required this.icono});

  factory Medida.fromJson(Map<String, dynamic> j) => Medida(
    id: (j['id'] ?? '') as String,
    titulo: (j['titulo'] ?? '') as String,
    descripcion: (j['descripcion'] ?? '') as String,
    categoria: (j['categoria'] ?? '') as String,
    icono: (j['icono'] ?? '') as String,
  );
}
