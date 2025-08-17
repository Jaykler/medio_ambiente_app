import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgs = [
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
      'https://images.unsplash.com/photo-1502082553048-f009c37129b9',
      'https://images.unsplash.com/photo-1493815793585-6cce922c644a',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          CarouselSlider(
            items: imgs.map((u) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(u, fit: BoxFit.cover, width: double.infinity),
            )).toList(),
            options: CarouselOptions(height: 200, autoPlay: true),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Protege lo que amas: recicla, conserva y cuida las áreas protegidas.',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}