import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fauget Pizzeria',
      theme: ThemeData(
        primaryColor: Color(0xFFD93D04), // Vermelho principal
        scaffoldBackgroundColor: Color(0xFFFAF0DC), // Fundo bege claro
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD93D04), // Vermelho
          foregroundColor: Colors.white, // Texto branco
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD93D04), // Vermelho
            foregroundColor: Colors.white, // Texto branco
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFD93D04), // Vermelho
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
      home: HomeScreen(),
    );
  }
}
