import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_project/screens/user_profilr_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  String title = 'loading...';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 34),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(user: _getData()),
                    ),
                  );
                },
                child: Text(
                  'click to get data!',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getData() async {
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    Response response = await get(uri);

    int id = jsonDecode(response.body)['id'];
    String name = jsonDecode(response.body)['name'];
    String username = jsonDecode(response.body)['username'];
    String city = jsonDecode(response.body)['address']['city'];
    String phone = jsonDecode(response.body)['phone'];

    //print(response.body);
  }
}
