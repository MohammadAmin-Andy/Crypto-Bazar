import 'package:flutter/material.dart';
import 'package:network_project/secondscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SecondPage();
                },
              ),
            );
          },
          child: Text('go to seconed screen'),
        ),
      ),
    );
  }
}
