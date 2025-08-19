import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/noticias_provider.dart';
import 'package:medio_ambiente_app/models/noticia.dart';

class NoticiasPage extends StatefulWidget {
  const NoticiasPage({super.key});
  @override
  State<NoticiasPage> createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NoticiasProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NoticiasProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : ListView.separated(
                  itemCount: vm.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) => _NoticiaTile(n: vm.items[i]),
                ),
    );
  }
}

class _NoticiaTile extends StatelessWidget {
  final Noticia n;
  const _NoticiaTile({required this.n});

  @override
  Widget build(BuildContext context) {
    final fechaStr = n.fecha != null ? '${n.fecha!.year}-${n.fecha!.month.toString().padLeft(2,'0')}-${n.fecha!.day.toString().padLeft(2,'0')}' : '';
    return ListTile(
      leading: n.imagen == null || n.imagen!.isEmpty
          ? const Icon(Icons.image_not_supported)
          : ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(n.imagen!, width: 56, height: 56, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
      title: Text(n.titulo),
      subtitle: Text(
        [fechaStr, n.resumen].where((s) => s.isNotEmpty).join(' • '),
        maxLines: 2, overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
