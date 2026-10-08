import 'package:flutter/material.dart';
import 'package:wisata_bandung1/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Bandung',
      debugShowCheckedModeBanner: false, // Menghilangkan pita debug
      theme: ThemeData(
        // Menggunakan warna latar belakang khas iOS (System Gray 6)
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F2F7),
          elevation: 0, // Menghilangkan bayangan/garis batas bawah AppBar
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const MainScreen(),
    );
  }
}