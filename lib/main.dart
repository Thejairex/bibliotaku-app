import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Se utiliza para asegurar que el entorno de Flutter esté inicializado antes de ejecutar el código.

  await dotenv.load(fileName: ".env");

  // Se utiliza el ProviderScope para envolver la aplicación, lo que permite que los proveedores de Riverpod sean accesibles para todos los widgets de la aplicación.
  runApp(
    const ProviderScope(
      child: BibliotakuApp(),
    ),
  );
}
