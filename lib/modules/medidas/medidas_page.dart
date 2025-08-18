import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/medidas_provider.dart';

class MedidasPage extends StatefulWidget {
  const MedidasPage({super.key});
  @override
  State<MedidasPage> createState() => _MedidasPageState();
}

class _MedidasPageState extends State<MedidasPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MedidasProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MedidasProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Medidas Ambientales')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : ListView.separated(
                  itemCount: vm.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final m = vm.items[i];
                    return ListTile(
                      title: Text(m.titulo),
                      subtitle: Text(m.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
                    );
                  },
                ),
    );
  }
}
