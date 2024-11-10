import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      title: 'Music Player App',
      theme: ThemeData(
       fontFamily: "regular",
       appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
       ),
      ),
      

    );

  }
    
}
