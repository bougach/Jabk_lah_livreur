
import 'package:flutter/material.dart';
import 'package:jabklah_livreur/login/login.dart';

import 'ordersPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Livreure_App",
      home: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF1E6FF), Color(0xFF6F35A5)], // Set the desired gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: Text('Delivery App'),
          ),
          body: Body()
      ),



    );
  }
}


