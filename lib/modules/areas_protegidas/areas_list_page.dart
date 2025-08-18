// El disparate que hizo libe x2
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/areas_provider.dart';
import '../../models/area_protegida.dart';
import '../../routes/app_routes.dart';

class AreasListPage extends StatefulWidget {
  const AreasListPage({super.key});

  @override
  State<AreasListPage> createState() => _AreasListPageState();
}

class _AreasListPageState extends State<AreasListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<AreaProtegida> _filteredAreas = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AreasProvider>().load());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterAreas(List<AreaProtegida> areas) {
    if (_searchQuery.isEmpty) {
      _filteredAreas = areas;
    } else {
      _filteredAreas = areas.where((area) {
        return area.nombre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               area.ubicacion.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               area.tipo.toLowerCase().contains(_searchQuery.toLowerCase()) ||
               area.descripcion.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Áreas Protegidas'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.mapaAreas),
            tooltip: 'Ver en mapa',
          ),
        ],
      ),
      body: Consumer<AreasProvider>(
        builder: (context, provider, child) {
          _filterAreas(provider.items);
          
          return Column(
            children: [
              // Barra de búsqueda
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.green.shade50,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar áreas protegidas...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF2E7D32)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Color(0xFF2E7D32)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
              ),

              // Contenido principal
              Expanded(
                child: _buildContent(provider, _filteredAreas),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(AreasProvider provider, List<AreaProtegida> areas) {
    if (provider.loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF2E7D32)),
            SizedBox(height: 16),
            Text('Cargando áreas protegidas...'),
          ],
        ),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: ${provider.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => provider.load(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (areas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isEmpty ? Icons.nature : Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No hay áreas protegidas disponibles'
                  : 'No se encontraron resultados para "$_searchQuery"',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            if (_searchQuery.isNotEmpty) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                },
                child: const Text('Limpiar búsqueda'),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: areas.length,
      itemBuilder: (context, index) {
        final area = areas[index];
        return AreaCard(
          area: area,
          onTap: () => _navigateToDetail(area),
        );
      },
    );
  }

  void _navigateToDetail(AreaProtegida area) {
    Navigator.pushNamed(
      context,
      AppRoutes.areaDetail,
      arguments: area,
    );
  }
}

class AreaCard extends StatelessWidget {
  final AreaProtegida area;
  final VoidCallback onTap;

  const AreaCard({
    super.key,
    required this.area,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // Imagen del área
            if (area.imagen.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  area.imagen,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: const Color(0xFF2E7D32),
                      child: const Icon(
                        Icons.nature,
                        size: 60,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E7D32),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: const Icon(
                  Icons.nature,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header con nombre y tipo
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          area.nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          area.tipo,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Ubicación
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          area.ubicacion,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Superficie
                  if (area.superficie.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.area_chart, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Superficie: ${area.superficie}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 8),

                  // Descripción (truncada)
                  Text(
                    area.descripcion,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),

                  const SizedBox(height: 12),

                  // Footer con botón
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.gps_fixed, size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            'GPS: ${area.latitud.toStringAsFixed(2)}, ${area.longitud.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: onTap,
                        child: const Text(
                          'Ver detalles',
                          style: TextStyle(color: Color(0xFF2E7D32)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}