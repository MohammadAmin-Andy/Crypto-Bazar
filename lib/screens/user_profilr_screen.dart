import 'package:flutter/material.dart';
import 'package:network_project/data/model/user.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key, this.user});
  List<User>? user;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<User>? userList;
  @override
  void initState() {
    //String username = '';
    // TODO: implement initState
    super.initState();
    userList = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: userList!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.red,
                child: Text(
                  userList![index].name,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
