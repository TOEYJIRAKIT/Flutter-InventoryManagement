import 'package:productmanage/models/users.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Users;

    // Generate random RGB color values
    final Random random = Random();
    final int red = random.nextInt(256);
    final int green = random.nextInt(256);
    final int blue = random.nextInt(256);

    // Create a Color object with the random color values
    final backgroundColor = Color.fromRGBO(red, green, blue, 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Info"),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              ListTile(
                title: Text("Full Name"),
                subtitle: Text("${user.username}"),
              ),
              ListTile(
                title: Text("Email"),
                subtitle: Text("${user.email}"),
              ),
              ListTile(
                title: Text("Address"),
                subtitle: Text("${user.address}"),
              ),
              ListTile(
                title: Text("BirthDate"),
                subtitle: Text("${user.birthdate}"),
              ),
              ListTile(
                title: Text("Age"),
                subtitle: Text("${user.age} years"),
              ),
              ListTile(
                title: Text("Gender"),
                subtitle: Text("${user.gender}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
