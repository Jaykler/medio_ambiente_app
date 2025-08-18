class Noticia {
  final int id;
  final String titulo;
  final String resumen;
  final String contenido;
  final String? imagen;
  final DateTime? fecha;

  Noticia({
    required this.id,
    required this.titulo,
    required this.resumen,
    required this.contenido,
    this.imagen,
    this.fecha,
  });

  factory Noticia.fromJson(Map<String, dynamic> j) => Noticia(
    id: (j['id'] ?? 0) as int,
    titulo: (j['titulo'] ?? '') as String,
    resumen: (j['resumen'] ?? '') as String,  
    contenido: (j['contenido'] ?? '') as String,
    imagen: (j['imagen'] ?? j['imagen_url'] ?? j['foto']) as String?,
    fecha: (j['fecha'] != null && j['fecha'].toString().isNotEmpty)
        ? DateTime.tryParse(j['fecha'].toString())
        : null,
  );
}
