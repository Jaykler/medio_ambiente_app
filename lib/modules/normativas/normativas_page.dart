import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/normativas_provider.dart';
import 'package:medio_ambiente_app/models/normativa.dart';
import 'package:medio_ambiente_app/routes/app_routes.dart';

class NormativasPage extends StatefulWidget {
  const NormativasPage({super.key});

  @override
  State<NormativasPage> createState() => _NormativasPageState();
}

class _NormativasPageState extends State<NormativasPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<NormativasProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NormativasProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Normativas ambientales')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : ListView.separated(
                  itemCount: vm.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) => _NormativaTile(n: vm.items[i]),
                ),
    );
  }
}

class _NormativaTile extends StatelessWidget {
  final Normativa n;
  const _NormativaTile({required this.n});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(n.titulo),
      subtitle: Text(n.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: const Icon(Icons.picture_as_pdf),
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.pdf, arguments: n.urlPdf),
    );
  }
}