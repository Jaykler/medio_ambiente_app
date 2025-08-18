import 'package:flutter/material.dart';
import 'package:medio_ambiente_app/data/providers/areas_provider.dart';
import 'package:medio_ambiente_app/data/providers/auth_provider.dart';
import 'package:medio_ambiente_app/data/providers/normativas_provider.dart';
import 'package:provider/provider.dart';

// Services
import 'core/services/api_service.dart';
import 'core/services/storage_service.dart';

// Repositories
import 'data/repositories/normativas_repository.dart';
import 'data/repositories/areas_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/servicios_repository.dart';
import 'data/repositories/noticias_repository.dart';
import 'data/repositories/videos_repository.dart';
import 'data/repositories/medidas_repository.dart';
import 'data/repositories/equipo_repository.dart';

// Providers nuevos
import 'data/providers/servicios_provider.dart';
import 'data/providers/noticias_provider.dart';
import 'data/providers/videos_provider.dart';
import 'data/providers/medidas_provider.dart';
import 'data/providers/equipo_provider.dart';

// Router
import 'routes/app_router.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancias compartidas (un solo ApiService para todo)
    final api = ApiService();
    final storage = StorageService();

    return MultiProvider(
      providers: [
        // AUTH (punto 3.3)
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepository(api, storage)),
        ),

        // Datos
        ChangeNotifierProvider(
          create: (_) => NormativasProvider(NormativasRepository(api)),
        ),
        ChangeNotifierProvider(
          create: (_) => AreasProvider(AreasRepository(api)),
        ),
        ChangeNotifierProvider(create: (_) => ServiciosProvider(ServiciosRepository(api))),
    ChangeNotifierProvider(create: (_) => NoticiasProvider(NoticiasRepository(api))),
    ChangeNotifierProvider(create: (_) => VideosProvider(VideosRepository(api))),
    ChangeNotifierProvider(create: (_) => MedidasProvider(MedidasRepository(api))),
    ChangeNotifierProvider(create: (_) => EquipoProvider(EquipoRepository(api))),
        // → Cuando agregues más módulos (Servicios, Noticias, etc.),
        //   crea aquí sus Providers con el mismo 'api'
        // ChangeNotifierProvider(create: (_) => ServiciosProvider(ServiciosRepository(api))),
        // ChangeNotifierProvider(create: (_) => NoticiasProvider(NoticiasRepository(api))),
      ],
      child: MaterialApp(
        title: 'Medio Ambiente RD',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF2E7D32),
        ),
        initialRoute: AppRoutes.inicio,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
