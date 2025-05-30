import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authViewModelProvider);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Correo")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final success = await ref.read(authViewModelProvider.notifier).login(
                      emailController.text,
                      passwordController.text,
                    );
                if (success && context.mounted) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
                }
              },
              child: const Text("Entrar"),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
              child: const Text("¿No tienes cuenta? Regístrate"),
            ),
          ],
        ),
      ),
    );
  }
}
