// Lisbeth djg
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreNosotrosPage extends StatelessWidget {
  const SobreNosotrosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo del Ministerio
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: const Color(0xFF2E7D32), width: 3),
                ),
                child: const Icon(
                  Icons.eco,
                  size: 60,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Título principal
            const Center(
              child: Text(
                'Ministerio de Medio Ambiente\ny Recursos Naturales',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Historia
            _buildSection(
              'Nuestra Historia',
              'El Ministerio de Medio Ambiente y Recursos Naturales de la República Dominicana fue creado mediante la Ley 64-00, con el propósito de ser la institución rectora de la gestión del medio ambiente, los ecosistemas y los recursos naturales del país.\n\nDesde su creación, hemos trabajado incansablemente para promover el desarrollo sostenible, la conservación de nuestros recursos naturales y la protección del medio ambiente para las futuras generaciones.',
              Icons.history,
            ),
            
            const SizedBox(height: 24),
            
            // Misión
            _buildSection(
              'Nuestra Misión',
              'Liderar la gestión del medio ambiente y los recursos naturales de la República Dominicana, promoviendo el desarrollo sostenible a través de políticas, programas y acciones que garanticen la conservación, protección, restauración y uso racional del patrimonio natural del país.',
              Icons.flag,
            ),
            
            const SizedBox(height: 24),
            
            // Visión
            _buildSection(
              'Nuestra Visión',
              'Ser reconocidos como la institución líder en la región en la gestión integral del medio ambiente y los recursos naturales, contribuyendo al bienestar de la población dominicana y al desarrollo sostenible del país, mediante la aplicación de las mejores prácticas ambientales.',
              Icons.visibility,
            ),
            
            const SizedBox(height: 32),
            
            // Video institucional
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.video_library, color: Color(0xFF2E7D32)),
                        SizedBox(width: 8),
                        Text(
                          'Video Institucional',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 60,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Video sobre Medio Ambiente RD',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => _launchVideo(),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Ver Video'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Objetivos principales
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.eco, color: Color(0xFF2E7D32)),
                        SizedBox(width: 8),
                        Text(
                          'Nuestros Objetivos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildObjective('Proteger y conservar los ecosistemas naturales'),
                    _buildObjective('Promover el uso sostenible de los recursos naturales'),
                    _buildObjective('Prevenir y controlar la contaminación ambiental'),
                    _buildObjective('Fomentar la educación y conciencia ambiental'),
                    _buildObjective('Implementar políticas de desarrollo sostenible'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection(String title, String content, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF2E7D32)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildObjective(String objective) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF2E7D32),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              objective,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
  
  void _launchVideo() async {
    // URL de ejemplo - reemplaza con el video real del ministerio
    const url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
    final uri = Uri.parse(url);
    
    try {
      await launchUrl(uri);
    } catch (e) {
      // Si no puede abrir el enlace, muestra un mensaje
      print('Error al abrir el video: $e');
    }
  }
}