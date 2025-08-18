import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/equipo_provider.dart';

class EquipoPage extends StatefulWidget {
  const EquipoPage({super.key});
  @override
  State<EquipoPage> createState() => _EquipoPageState();
}

class _EquipoPageState extends State<EquipoPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<EquipoProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EquipoProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Equipo del Ministerio')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : ListView.separated(
                  itemCount: vm.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final p = vm.items[i];
                    return ListTile(
                      leading: p.fotoUrl == null || p.fotoUrl!.isEmpty
                          ? const CircleAvatar(child: Icon(Icons.person))
                          : CircleAvatar(backgroundImage: NetworkImage(p.fotoUrl!)),
                      title: Text(p.nombre),
                      subtitle: Text(p.cargo),
                    );
                  },
                ),
    );
  }
}
