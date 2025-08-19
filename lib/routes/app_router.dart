import 'package:flutter/material.dart';
import 'package:medio_ambiente_app/modules/auth/login_page.dart';
import 'package:medio_ambiente_app/modules/inicio/inicio_page.dart';
import 'package:medio_ambiente_app/modules/normativas/normativas_page.dart';
import 'package:medio_ambiente_app/modules/normativas/pdf_viewer_page.dart';
import 'package:medio_ambiente_app/modules/mapa_areas/mapa_areas_page.dart';
import 'package:medio_ambiente_app/modules/servicios/servicios_page.dart';
import 'package:medio_ambiente_app/modules/noticias/noticias_page.dart';
import 'package:medio_ambiente_app/modules/shell/main_shell.dart';
import 'package:medio_ambiente_app/modules/videos/videos_page.dart';
import 'package:medio_ambiente_app/modules/medidas/medidas_page.dart';
import 'package:medio_ambiente_app/modules/equipo/equipo_page.dart';
import 'package:medio_ambiente_app/modules/reportes/mapa_reportes_page.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.inicio:
      return MaterialPageRoute(builder: (_) => const InicioPage());
    case AppRoutes.normativas:
      return MaterialPageRoute(builder: (_) => const NormativasPage());
    case AppRoutes.pdf:
      final url = settings.arguments as String? ?? '';
      return MaterialPageRoute(builder: (_) => PdfViewerPage(url: url));
    case AppRoutes.mapaAreas:
      return MaterialPageRoute(builder: (_) => const MapaAreasPage());

    case AppRoutes.servicios:
      return MaterialPageRoute(builder: (_) => const ServiciosPage());
    case AppRoutes.noticias:
      return MaterialPageRoute(builder: (_) => const NoticiasPage());
    case AppRoutes.videos:
      return MaterialPageRoute(builder: (_) => const VideosPage());
    case AppRoutes.medidas:
      return MaterialPageRoute(builder: (_) => const MedidasPage());
    case AppRoutes.equipo:
      return MaterialPageRoute(builder: (_) => const EquipoPage());
    case AppRoutes.shell:
    return MaterialPageRoute(builder: (_) => const MainShell());
    case AppRoutes.mapaReportes:
      return MaterialPageRoute(builder: (_) => const MapaReportesPage());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    default:
      return MaterialPageRoute(builder: (_) => const InicioPage());
  }
}
