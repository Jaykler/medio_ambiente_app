import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/mis_reportes_provider.dart';
import 'package:medio_ambiente_app/models/reporte.dart';

class MapaReportesPage extends StatefulWidget {
  const MapaReportesPage({super.key});

  @override
  State<MapaReportesPage> createState() => _MapaReportesPageState();
}

class _MapaReportesPageState extends State<MapaReportesPage> {
  final _mapController = MapController();
  LatLng _center = const LatLng(18.7357, -70.1627); // RD centro

  @override
  void initState() {
    super.initState();
    // Asegura que estén cargados (si entras directo)
    Future.microtask(() async {
      final vm = context.read<MisReportesProvider>();
      if (vm.items.isEmpty && !vm.loading) await vm.load();
      if (vm.items.isNotEmpty) {
        final first = vm.items.first;
        setState(() => _center = LatLng(first.lat, first.lng));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MisReportesProvider>();
    final markers = vm.items.map(_markerFromReporte).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de mis reportes')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(initialCenter: _center, initialZoom: 8),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 45,
                    size: const Size(44, 44),
                    markers: markers, // tu List<Marker>
                    // (Opcionales útiles)
                    spiderfyCircleRadius: 40,
                    spiderfySpiralDistanceMultiplier: 2,
                    showPolygon: false,
                    builder: (context, markers) => Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF49BA86),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${markers.length}',              // 👈 reemplaza cluster.count
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Marker _markerFromReporte(Reporte r) {
    return Marker(
      point: LatLng(r.lat, r.lng),
      width: 44,
      height: 44,
      child: GestureDetector(
        onTap: () => _showPopup(r),
        child: const Icon(Icons.location_on, size: 40, color: Colors.red),
      ),
    );
  }

  void _showPopup(Reporte r) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(r.titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(r.descripcion),
            const SizedBox(height: 8),
            Text('Ubicación: ${r.lat.toStringAsFixed(5)}, ${r.lng.toStringAsFixed(5)}'),
            if (r.fotoBase64 != null && r.fotoBase64!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Image.memory(base64Decode(r.fotoBase64!)),
            ],
          ],
        ),
      ),
    );
  }
}
