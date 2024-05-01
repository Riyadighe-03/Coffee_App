import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_app/dash_board.dart';
import 'package:coffee_app/item_details.dart';
import 'package:coffee_app/my_cart.dart';
import 'package:coffee_app/product_details.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
          options: const FirebaseOptions(
              appId: '1:270686430109:android:2ff0d0b50478af59d78574',
              apiKey: 'AIzaSyDg6juebt97ltL4HwIhUevKsSXccWicFxc',
              messagingSenderId: '',
              projectId: 'coffee-app-55e6d',
              storageBucket: "coffee-app-55e6d.appspot.com"))
      .then((value) => print("Successfull"))
      .then((value) => debugPrint("firebase initialised"));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DashBoard(),
      ),
    );
  }
}
