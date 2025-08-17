import 'package:flutter/material.dart';
import 'package:medio_ambiente_app/modules/inicio/inicio_page.dart';
import 'package:medio_ambiente_app/modules/normativas/normativas_page.dart';
import 'package:medio_ambiente_app/modules/normativas/pdf_viewer_page.dart';
import 'package:medio_ambiente_app/modules/mapa_areas/mapa_areas_page.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.inicio:
      return MaterialPageRoute(builder: (_) => const InicioPage());
    case AppRoutes.normativas:
      return MaterialPageRoute(builder: (_) => const NormativasPage());
    case AppRoutes.pdf:
      final url = settings.arguments as String?;
      return MaterialPageRoute(builder: (_) => PdfViewerPage(url: url ?? ''));
    case AppRoutes.mapaAreas:
      return MaterialPageRoute(builder: (_) => const MapaAreasPage());
    default:
      return MaterialPageRoute(builder: (_) => const InicioPage());
  }
}