import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medio_ambiente_app/data/providers/videos_provider.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});
  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<VideosProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VideosProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : ListView.separated(
                  itemCount: vm.items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (_, i) {
                    final v = vm.items[i];
                    return ListTile(
                      leading: const Icon(Icons.play_circle),
                      title: Text(v.titulo),
                      subtitle: Text(v.url, maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () async {
                        final uri = Uri.parse(v.url);
                        if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
                      },
                    );
                  },
                ),
    );
  }
}
