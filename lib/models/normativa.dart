class Normativa {
  final int id;
  final String titulo;
  final String descripcion;
  final String urlPdf; // enlace al PDF

  Normativa({required this.id, required this.titulo, required this.descripcion, required this.urlPdf});

  factory Normativa.fromJson(Map<String, dynamic> j) => Normativa(
    id: (j['id'] ?? 0) as int,
    titulo: (j['titulo'] ?? '') as String,
    descripcion: (j['descripcion'] ?? '') as String,
    urlPdf: (j['url_pdf'] ?? j['pdf'] ?? '') as String,
  );
}