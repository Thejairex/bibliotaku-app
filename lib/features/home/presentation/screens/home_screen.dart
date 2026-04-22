import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  //Constructor de la clase
  const HomeScreen({super.key});

  // Método que construye el widget
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Se utiliza para aplicar el tema de la aplicación

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bibliotaku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bienvenido a Bibliotaku',
                  style: theme.textTheme.headlineMedium // Se utiliza el text theme de la aplicación
                ),
                const SizedBox(height: 12),
                Text(
                  'Tu biblioteca personal de mangas',
                  style: theme.textTheme.bodyLarge
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}