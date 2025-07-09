import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecuperarPasswordPage extends StatefulWidget {
  const RecuperarPasswordPage({super.key});

  @override
  State<RecuperarPasswordPage> createState() => _RecuperarPasswordPageState();
}

class _RecuperarPasswordPageState extends State<RecuperarPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  String mensaje = '';

  Future<void> enviarCorreoRecuperacion() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      setState(() {
        mensaje = '📧 Se ha enviado un enlace de recuperación a tu correo.';
      });
    } catch (e) {
      setState(() {
        mensaje = '❌ Error: Verifica que el correo esté registrado.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.lock_reset, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Ingresa tu correo para recuperar tu contraseña',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: enviarCorreoRecuperacion,
              icon: const Icon(Icons.send),
              label: const Text('Enviar enlace'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 189, 189, 189),
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              mensaje,
              style: const TextStyle(color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}