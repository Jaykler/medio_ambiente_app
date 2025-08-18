import 'package:flutter/material.dart';
import 'package:medio_ambiente_app/modules/inicio/inicio_page.dart';
import 'package:medio_ambiente_app/modules/normativas/normativas_page.dart';
import 'package:medio_ambiente_app/modules/normativas/pdf_viewer_page.dart';
import 'package:medio_ambiente_app/modules/mapa_areas/mapa_areas_page.dart';
import 'package:medio_ambiente_app/modules/servicios/servicios_page.dart';
import 'package:medio_ambiente_app/modules/noticias/noticias_page.dart';
import 'package:medio_ambiente_app/modules/videos/videos_page.dart';
import 'package:medio_ambiente_app/modules/medidas/medidas_page.dart';
import 'package:medio_ambiente_app/modules/equipo/equipo_page.dart';
import 'package:medio_ambiente_app/modules/sobre_nosotros/sobre_nosotros_page.dart';
import 'package:medio_ambiente_app/modules/areas_protegidas/areas_list_page.dart'; // libe djg
import 'package:medio_ambiente_app/modules/areas_protegidas/area_detail_page.dart'; //libedjg
import 'package:medio_ambiente_app/models/area_protegida.dart'; // libe djg
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.inicio:
      return MaterialPageRoute(builder: (_) => const InicioPage());
    case AppRoutes.sobreNosotros:
      return MaterialPageRoute(builder: (_) => const SobreNosotrosPage());
    case AppRoutes.areasProtegidas: 
      return MaterialPageRoute(builder: (_) => const AreasListPage());
    case AppRoutes.areaDetail: 
      final area = settings.arguments as AreaProtegida;
      return MaterialPageRoute(builder: (_) => AreaDetailPage(area: area));
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

    default:
      return MaterialPageRoute(builder: (_) => const InicioPage());
  }
}