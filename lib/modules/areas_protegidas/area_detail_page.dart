// El disparate que hizo libe
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/area_protegida.dart';
import '../../routes/app_routes.dart';

class AreaDetailPage extends StatelessWidget {
  final AreaProtegida area;

  const AreaDetailPage({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar con imagen de fondo
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.map),
                onPressed: () => Navigator.pushNamed(context, AppRoutes.mapaAreas),
                tooltip: 'Ver en mapa',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                area.nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (area.imagen.isNotEmpty)
                    Image.network(
                      area.imagen,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF2E7D32),
                          child: const Icon(
                            Icons.nature,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    )
                  else
                    Container(
                      color: const Color(0xFF2E7D32),
                      child: const Icon(
                        Icons.nature,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  // Overlay oscuro para mejorar legibilidad del título
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chip con tipo de área
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text(
                        area.tipo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color(0xFF2E7D32),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Información básica
                  _buildInfoSection(
                    'Información General',
                    [
                      _InfoItem(
                        icon: Icons.location_on,
                        title: 'Ubicación',
                        content: area.ubicacion,
                      ),
                      if (area.superficie.isNotEmpty)
                        _InfoItem(
                          icon: Icons.area_chart,
                          title: 'Superficie',
                          content: area.superficie,
                        ),
                      _InfoItem(
                        icon: Icons.gps_fixed,
                        title: 'Coordenadas',
                        content: 'Lat: ${area.latitud.toStringAsFixed(6)}, Lng: ${area.longitud.toStringAsFixed(6)}',
                      ),
                      _InfoItem(
                        icon: Icons.badge,
                        title: 'ID',
                        content: area.id,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Descripción
                  _buildDescriptionSection(),

                  const SizedBox(height: 24),

                  // Acciones
                  _buildActionsSection(context),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<_InfoItem> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        item.icon,
                        size: 20,
                        color: const Color(0xFF2E7D32),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.content,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.description,
                  color: Color(0xFF2E7D32),
                ),
                SizedBox(width: 8),
                Text(
                  'Descripción',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              area.descripcion,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.touch_app,
                  color: Color(0xFF2E7D32),
                ),
                SizedBox(width: 8),
                Text(
                  'Acciones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Botón de ver en mapa
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.mapaAreas);
                },
                icon: const Icon(Icons.map),
                label: const Text('Ver en Mapa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Botón de compartir coordenadas
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _shareLocation(),
                icon: const Icon(Icons.share_location),
                label: const Text('Compartir Ubicación'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2E7D32),
                  side: const BorderSide(color: Color(0xFF2E7D32)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Botón de abrir en Google Maps
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openInGoogleMaps(),
                icon: const Icon(Icons.navigation),
                label: const Text('Abrir en Google Maps'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2E7D32),
                  side: const BorderSide(color: Color(0xFF2E7D32)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareLocation() {
    // Aquí puedes implementar la funcionalidad de compartir
    // Por ejemplo, usando el paquete share_plus
    print('Compartir: ${area.nombre} - ${area.latitud}, ${area.longitud}');
  }

  void _openInGoogleMaps() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${area.latitud},${area.longitud}';
    final uri = Uri.parse(url);
    
    try {
      await launchUrl(uri);
    } catch (e) {
      print('Error al abrir Google Maps: $e');
    }
  }
}

class _InfoItem {
  final IconData icon;
  final String title;
  final String content;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.content,
  });
}