import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';
  
abstract final class AppTheme {
  // Método que construye el tema de la aplicación en modo claro
  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light, // Brillo de la aplicación
    );

  
    return ThemeData(
      useMaterial3: true, // Se utiliza para habilitar el uso de Material 3
      colorScheme: colorScheme, // Se utiliza para aplicar el color scheme de la aplicación
      scaffoldBackgroundColor: AppColors.lightBackground, // Color de fondo de la aplicación
      textTheme: AppTextTheme.build(ThemeData(brightness: Brightness.light).textTheme), // Se utiliza para aplicar el text theme de la aplicación
      appBarTheme: AppBarTheme(
        centerTitle: false, // Centra el título de la barra de navegación
        backgroundColor: colorScheme.surface, // Color de fondo de la barra de navegación
        foregroundColor: colorScheme.onSurface, // Color del texto de la barra de navegación
      ),
      cardTheme: CardThemeData(
        elevation: 0, // Elevación de la tarjeta
        color: colorScheme.surfaceContainerLow, // Color de fondo de la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados de la tarjeta
        ),
      ),
    );
  }
  
  // Método que construye el tema de la aplicación en modo oscuro
  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.dark, // Brillo de la aplicación
    );

    return ThemeData(
      useMaterial3: true, // Se utiliza para habilitar el uso de Material 3
      colorScheme: colorScheme, // Se utiliza para aplicar el color scheme de la aplicación
      scaffoldBackgroundColor: AppColors.darkBackground, // Color de fondo de la aplicación
      textTheme: AppTextTheme.build(ThemeData(brightness: Brightness.dark).textTheme), // Se utiliza para aplicar el text theme de la aplicación
      appBarTheme: AppBarTheme(
        centerTitle: false, // Centra el título de la barra de navegación
        backgroundColor: colorScheme.surface, // Color de fondo de la barra de navegación
        foregroundColor: colorScheme.onSurface, // Color del texto de la barra de navegación
      ),
      cardTheme: CardThemeData(
        elevation: 0, // Elevación de la tarjeta
        color: colorScheme.surfaceContainerLow, // Color de fondo de la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados de la tarjeta
        ),
      ),
    );
  }
}