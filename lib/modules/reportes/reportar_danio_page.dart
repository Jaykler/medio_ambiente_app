import 'package:flutter/material.dart';
import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/services/location_service.dart';
import 'package:medio_ambiente_app/data/repositories/reportes_repository.dart';
import 'package:medio_ambiente_app/models/reporte.dart';

class ReportarDanioPage extends StatefulWidget {
  const ReportarDanioPage({super.key});

  @override
  State<ReportarDanioPage> createState() => _ReportarDanioPageState();
}

class _ReportarDanioPageState extends State<ReportarDanioPage> {
  final _formKey = GlobalKey<FormState>();
  final _tTitulo = TextEditingController();
  final _tDesc = TextEditingController();
  final _loc = LocationService();
  double? _lat, _lng;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final pos = await _loc.getCurrentPosition();
      setState(() { _lat = pos.latitude; _lng = pos.longitude; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportar daño ambiental')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(controller: _tTitulo, decoration: const InputDecoration(labelText: 'Título'), validator: _req),
            const SizedBox(height: 12),
            TextFormField(controller: _tDesc, decoration: const InputDecoration(labelText: 'Descripción'), maxLines: 4, validator: _req),
            const SizedBox(height: 12),
            if (_lat != null) Text('Ubicación: ${_lat!.toStringAsFixed(5)}, ${_lng!.toStringAsFixed(5)}'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('Enviar reporte'),
            ),
          ],
        ),
      ),
    );
  }

  String? _req(String? v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_lat == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ubicación no disponible')));
      return;
    }
    final reporte = Reporte(titulo: _tTitulo.text.trim(), descripcion: _tDesc.text.trim(), lat: _lat!, lng: _lng!);
    // TODO: llamar a repo para enviar vía API
    debugPrint('Reporte JSON: ${reporte.toJson()}');
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enviado (mock)')));
    
    final repo = ReportesRepository(ApiService());
    await repo.crearReporte(reporte);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reporte enviado')));
  }
  
}