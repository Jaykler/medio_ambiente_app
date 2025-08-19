import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/mis_reportes_provider.dart';
import 'package:medio_ambiente_app/models/reporte.dart';
import 'package:medio_ambiente_app/routes/app_routes.dart';

class MisReportesPage extends StatefulWidget {
  const MisReportesPage({super.key});
  @override
  State<MisReportesPage> createState() => _MisReportesPageState();
}

class _MisReportesPageState extends State<MisReportesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MisReportesProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MisReportesProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Mis reportes')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : vm.items.isEmpty
                  ? const Center(child: Text('No tienes reportes aún'))
                  : ListView.separated(
                      itemCount: vm.items.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (_, i) => _ReporteTile(r: vm.items[i]),
                    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.mapaReportes),
        icon: const Icon(Icons.map),
        label: const Text('Ver en mapa'),
      ),
    );
  }
}

class _ReporteTile extends StatelessWidget {
  final Reporte r;
  const _ReporteTile({required this.r});

  @override
  Widget build(BuildContext context) {
    final fecha = r.fecha != null
        ? '${r.fecha!.year}-${r.fecha!.month.toString().padLeft(2,'0')}-${r.fecha!.day.toString().padLeft(2,'0')}'
        : '';
    final img = (r.fotoBase64 != null && r.fotoBase64!.isNotEmpty)
        ? Image.memory(base64Decode(r.fotoBase64!), width: 56, height: 56, fit: BoxFit.cover)
        : const Icon(Icons.photo, size: 36);

    return ListTile(
      leading: ClipRRect(borderRadius: BorderRadius.circular(6), child: SizedBox(width: 56, height: 56, child: Center(child: img))),
      title: Text(r.titulo),
      subtitle: Text([fecha, '(${r.lat.toStringAsFixed(5)}, ${r.lng.toStringAsFixed(5)})', r.descripcion]
          .where((s) => s.isNotEmpty).join(' • '),
          maxLines: 2, overflow: TextOverflow.ellipsis),
      onTap: () => _detalle(context, r),
    );
  }

  void _detalle(BuildContext context, Reporte r) {
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
            const SizedBox(height: 12),
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
