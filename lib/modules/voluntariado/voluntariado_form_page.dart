import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medio_ambiente_app/data/providers/auth_provider.dart';

class VoluntariadoFormPage extends StatefulWidget {
  const VoluntariadoFormPage({super.key});
  @override
  State<VoluntariadoFormPage> createState() => _VoluntariadoFormPageState();
}

class _VoluntariadoFormPageState extends State<VoluntariadoFormPage> {
  final _k = GlobalKey<FormState>();
  final _cedula = TextEditingController();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _correo = TextEditingController();
  final _clave = TextEditingController();
  final _telefono = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Voluntariado')),
      body: Form(
        key: _k,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _f(_cedula, 'Cédula'), _gap(),
            _f(_nombre, 'Nombre'), _gap(),
            _f(_apellido, 'Apellido'), _gap(),
            _f(_correo, 'Correo'), _gap(),
            _f(_telefono, 'Teléfono'), _gap(),
            TextFormField(controller: _clave, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true, validator: _req),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: auth.loading ? null : () async {
                if (!(_k.currentState?.validate() ?? false)) return;
                await context.read<AuthProvider>().registerVolunteer(
                  cedula: _cedula.text.trim(),
                  nombre: _nombre.text.trim(),
                  apellido: _apellido.text.trim(),
                  correo: _correo.text.trim(),
                  password: _clave.text.trim(),
                  telefono: _telefono.text.trim(),
                );
                if (auth.error == null) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro enviado')));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error!)));
                }
              },
              child: auth.loading ? const CircularProgressIndicator() : const Text('Registrarme'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _f(TextEditingController c, String l) => TextFormField(controller: c, decoration: InputDecoration(labelText: l), validator: _req);
  SizedBox _gap() => const SizedBox(height: 12);
  String? _req(String? v) => (v == null || v.trim().isEmpty) ? 'Requerido' : null;
}
