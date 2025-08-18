class VideoItem {
  final String id;
  final String titulo;
  final String descripcion;
  final String url;
  final String thumbnail;
  final String categoria;
  final String duracion;

  VideoItem({required this.id, required this.titulo, required this.descripcion, required this.url, required this.thumbnail, required this.categoria, required this.duracion});

  factory VideoItem.fromJson(Map<String, dynamic> j) => VideoItem(
    id: (j['id'] ?? '') as String,
    titulo: (j['titulo'] ?? '') as String,
    descripcion: (j['descripcion'] ?? '') as String,
    url: (j['url'] ?? j['video'] ?? '') as String,
    thumbnail: (j['thumbnail'] ?? '') as String,
    categoria: (j['categoria'] ?? '') as String,
    duracion: (j['duracion'] ?? '') as String,
  );
}
