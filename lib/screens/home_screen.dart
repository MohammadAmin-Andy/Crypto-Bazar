import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_project/data/model/user.dart';
import 'package:network_project/screens/user_profilr_screen.dart';
import 'package:dio/dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  String title = 'loading...';
  User? user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[800],
        body: SafeArea(
          child: Center(
            child: SpinKitFadingCube(
              color: Colors.green,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }

  void _getData() async {
    //Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    //Response response = await get(uri);
//
    //int id = jsonDecode(response.body)['id'];
    //String name = jsonDecode(response.body)['name'];
    //String username = jsonDecode(response.body)['username'];
    //String city = jsonDecode(response.body)['address']['city'];
    //String phone = jsonDecode(response.body)['phone'];

    //User user = User(id, name, username, city, phone);
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/users');
    var test1 = response.data;

    List<User> userList = response.data
        .map<User>((jsonMapObject) => User.fromMapJson(jsonMapObject))
        .toList();
    var test2 = userList;
    print('test');

    // userList.forEach((Element) {
    //   print(Element.name);
    // });
    // var user = User.fromMapJson(jsonMapObject);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(user: userList),
      ),
    );
    //print(response.body);
  }
}
