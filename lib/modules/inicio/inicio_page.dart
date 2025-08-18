import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medio_ambiente_app/routes/app_routes.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgs = [
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
      'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
      'https://images.unsplash.com/photo-1493815793585-6cce922c644a',
    ];

    final opciones = [
      {'title': 'Sobre Nosotros', 'route': AppRoutes.sobreNosotros, 'icon': Icons.info},//libe djg
      {'title': 'Áreas Protegidas', 'route': AppRoutes.areasProtegidas, 'icon': Icons.nature_people}, // libe djg
      {'title': 'Servicios', 'route': AppRoutes.servicios, 'icon': Icons.handshake},
      {'title': 'Noticias', 'route': AppRoutes.noticias, 'icon': Icons.newspaper},
      {'title': 'Videos', 'route': AppRoutes.videos, 'icon': Icons.video_collection},
      {'title': 'Medidas', 'route': AppRoutes.medidas, 'icon': Icons.eco},
      {'title': 'Equipo', 'route': AppRoutes.equipo, 'icon': Icons.group},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          CarouselSlider(
            items: imgs.map((u) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(u, fit: BoxFit.cover, width: double.infinity),
            )).toList(),
            options: CarouselOptions(height: 200, autoPlay: true),
          ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Protege lo que amas: recicla, conserva y cuida las áreas protegidas.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),

          // 👇 Tarjetas institucionales
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 tarjetas por fila
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1, // cuadradas
              ),
              itemCount: opciones.length,
              itemBuilder: (_, i) {
                final op = opciones[i];
                return _OpcionCard(
                  title: op['title'] as String,
                  icon: op['icon'] as IconData,
                  onTap: () => Navigator.pushNamed(context, op['route'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OpcionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _OpcionCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const verdeInstitucional = Color(0xFF49BA86);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: verdeInstitucional,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center, // ← Agregado para centrar textos largos
              ),
            ],
          ),
        ),
      ),
    );
  }
}