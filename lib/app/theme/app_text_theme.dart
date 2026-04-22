import 'package:flutter/material.dart';

abstract final class AppTextTheme {
  // Método que construye el text theme de la aplicación
  static TextTheme build(TextTheme base ){
    // Se devuelve el text theme base con los estilos personalizados
    return base.copyWith(
      headlineMedium: base.headlineMedium?.copyWith( // Título mediano de la aplicación
        fontWeight: FontWeight.w700, // Peso de la fuente (700 = bold)
      ),
      // Se modifica el text theme para los títulos grandes
      titleLarge: base.titleLarge?.copyWith( 
        fontWeight: FontWeight.w600, // Peso de la fuente (600 = semi-bold)
      ),
      // Se modifica el text theme para el cuerpo grande
      bodyLarge: base.bodyLarge?.copyWith( // Cuerpo grande de la aplicación
        height: 1.4 // Espaciado entre líneas
      ),
    );
  }
}