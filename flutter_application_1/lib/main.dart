import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home.dart';
// import 'package:flutter_application_1/views/player.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';



void main() async {

  await Future.delayed(const Duration(seconds: 6));
  FlutterNativeSplash.remove();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      // home: const Player(),
      // home :  SplashScreen(),
      title: 'Music Player App',
      theme: ThemeData(
       fontFamily: "regular",
       appBarTheme: const AppBarTheme(
        backgroundColor: const Color.fromARGB(0, 21, 16, 16),
        elevation: 0,
       ),
      ),
      

    );

  }
    
}
