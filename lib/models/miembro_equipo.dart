class MiembroEquipo {
  final String id;
  final String nombre;
  final String cargo;
  final String? fotoUrl;

  MiembroEquipo({required this.id, required this.nombre, required this.cargo, this.fotoUrl});

  factory MiembroEquipo.fromJson(Map<String, dynamic> j) => MiembroEquipo(
    id: (j['id'] ?? '') as String,
    nombre: (j['nombre'] ?? '') as String,
    cargo: (j['cargo'] ?? j['puesto'] ?? '') as String,
    fotoUrl: (j['foto'] ?? j['imagen']) as String?,
  );
}
