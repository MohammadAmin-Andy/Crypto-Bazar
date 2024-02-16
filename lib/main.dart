import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_project/screens/home_screen.dart';

void main(List<String> args) {
  runApp(
    Application(),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(fontFamily: 'Mh'),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
