import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatefulWidget {
  final String url;
  const PdfViewerPage({super.key, required this.url});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfControllerPinch _controller;

  @override
  void initState() {
    super.initState();
    //_controller = PdfControllerPinch(document: PdfDocument.openDataFromUrl(widget.url));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documento PDF')),
      body: widget.url.isEmpty
          ? const Center(child: Text('URL de PDF no proporcionada'))
          : PdfViewPinch(controller: _controller),
    );
  }
}