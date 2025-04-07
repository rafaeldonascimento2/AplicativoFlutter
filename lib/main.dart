import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Carrega o app dentro do DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder, // Adiciona o DevicePreview ao app
      debugShowCheckedModeBanner: false,
      title: 'Fauget Pizzeria', // Título do app
      theme: ThemeData(
        primaryColor: Color(0xFFD93D04), // Cor primária do app (vermelho)
        scaffoldBackgroundColor: Color(
          0xFFFAF0DC,
        ), // Cor de fundo do app (bege claro)
        appBarTheme: AppBarTheme(
          // Estilo da barra superior
          backgroundColor: Color(0xFFD93D04),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD93D04),
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFD93D04), // Cor do texto do botão
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          // Estilo da barra de navegação inferior
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFD93D04),
          unselectedItemColor: Color(0xFFA0522D),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD93D04), width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA0522D), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      home: LoginScreen(), // Tela inicial do app
    );
  }
}
