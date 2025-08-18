import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/servicios_provider.dart';


class ServiciosPage extends StatefulWidget {
  const ServiciosPage({super.key});
  @override
  State<ServiciosPage> createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ServiciosProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ServiciosProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Servicios')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
            ? Center(child: Text('Error: ${vm.error}'))
            : ListView.separated(
                itemCount: vm.items.length,
                separatorBuilder: (_, __) => const Divider(height: 0),
                itemBuilder: (_, i) {
                  final s = vm.items[i];
                  return ListTile(
                    title: Text(s.nombre),
                    subtitle: Text(s.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
                  );
                },
              ),
    );
  }
}
