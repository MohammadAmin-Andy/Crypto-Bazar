import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_project/data/constant/constans.dart';
import 'package:network_project/data/model/crypto.dart';
import 'package:network_project/data/model/user.dart';
import 'package:network_project/screens/coin_list_screen.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              SpinKitWave(
                color: grayColor,
                size: 30,
              ),
            ],
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
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    //var test1 = response.data;

    List<Crypto> cryptoList = response.data['data']
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();
    // var test2 = userList;
    // print('test');

    // userList.forEach((Element) {
    //   print(Element.name);
    // });
    // var user = User.fromMapJson(jsonMapObject);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoinListScreen(cryptoList: cryptoList),
      ),
    );
    //print(response.body);
  }
}
