import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/core/services/location_service.dart';
import 'package:medio_ambiente_app/data/providers/areas_provider.dart';
import 'package:medio_ambiente_app/models/area_protegida.dart';

class MapaAreasPage extends StatefulWidget {
  const MapaAreasPage({super.key});

  @override
  State<MapaAreasPage> createState() => _MapaAreasPageState();
}

class _MapaAreasPageState extends State<MapaAreasPage> {
  final _mapController = MapController();
  final _loc = LocationService();
  LatLng _center = const LatLng(18.7357, -70.1627); // RD centro aproximado
  String _here = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final ok = await _loc.ensurePermission();
      if (ok) {
        final p = await _loc.getCurrentPosition();
        setState(() => _center = LatLng(p.latitude, p.longitude));
        _here = await _loc.reverseGeocode(p.latitude, p.longitude);
      }
      if (mounted) context.read<AreasProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AreasProvider>();

    final markers = vm.items
        .map((a) => Marker(
              width: 40,
              height: 40,
              point: LatLng(a.lat, a.lng),
              child: IconButton(
                icon: const Icon(Icons.location_on, size: 32),
                color: Colors.red,
                onPressed: () => _showArea(context, a),
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Áreas Protegidas')),
      body: Column(
        children: [
          if (_here.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Tu ubicación: $_here'),
            ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(initialCenter: _center, initialZoom: 8),
              children: [
                TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.example.app'),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showArea(BuildContext context, AreaProtegida a) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(a.nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(a.descripcion),
            const SizedBox(height: 12),
            Text('Lat: ${a.lat.toStringAsFixed(5)} | Lng: ${a.lng.toStringAsFixed(5)}'),
          ],
        ),
      ),
    );
  }
}