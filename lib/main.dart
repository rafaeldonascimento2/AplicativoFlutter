import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Só habilita no modo de desenvolvimento
      builder: (context) => MyApp(), // Carrega o app dentro do DevicePreview
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true, 
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Fauget Pizzeria',
      theme: ThemeData(
        primaryColor: Color(0xFFD93D04),
        scaffoldBackgroundColor: Color(0xFFFAF0DC),
        appBarTheme: AppBarTheme(
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
            foregroundColor: Color(0xFFD93D04),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
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
      home: LoginScreen(),
    );
  }
}
