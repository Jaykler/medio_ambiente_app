import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:medio_ambiente_app/modules/inicio/inicio_page.dart';
import 'package:medio_ambiente_app/modules/normativas/normativas_page.dart';
import 'package:medio_ambiente_app/modules/mapa_areas/mapa_areas_page.dart';
import 'package:medio_ambiente_app/modules/reportes/mis_reportes_page.dart';
import 'package:medio_ambiente_app/modules/reportes/reportar_danio_page.dart';
import 'package:medio_ambiente_app/modules/auth/login_page.dart';

import 'package:medio_ambiente_app/data/providers/auth_provider.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    // Contenido de cada pestaña
    final pages = <Widget>[
      const InicioPage(),
      const NormativasPage(),
      const MapaAreasPage(),
      //auth.isLogged ? const MisReportesPage() : const LoginPage(), // protegido por sesión    MIRAR AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.picture_as_pdf_outlined), selectedIcon: Icon(Icons.picture_as_pdf), label: 'Normativas'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Mapa'),
          NavigationDestination(icon: Icon(Icons.report_outlined), selectedIcon: Icon(Icons.report), label: 'Reportes'),
        ],
      ),
      // FAB solo visible en pestaña "Reportes" y si hay sesión
      floatingActionButton: (_index == 3 && auth.isLogged)
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ReportarDanioPage()),
                );
              },
              icon: const Icon(Icons.add_location_alt),
              label: const Text('Nuevo reporte'),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
