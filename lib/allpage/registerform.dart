import 'dart:convert';

import 'package:productmanage/models/config.dart';
import 'package:productmanage/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formkey = GlobalKey<FormState>();
  //Users user = Users();
  late Users user;

  Future<void> addNewUser(user) async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = usersFromJson("[${resp.body}]");

    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    try {
      user = ModalRoute.of(context)!.settings.arguments as Users;
      print(user.username);
    } catch (e) {
      user = Users();
    }
    ;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Register Form"),
          backgroundColor: Color.fromRGBO(150, 130, 182, 1)),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fnameInputField(),
              emailInputField(),
              passwordInputField(),
              genderFormInput(),
              addressInputField(),
              birthdateInputField(),
              ageInputField(),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  submitButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: user.username,
      decoration:
          InputDecoration(labelText: "Username:", icon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.username = newValue,
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: user.email,
      decoration: InputDecoration(labelText: "Email:", icon: Icon(Icons.email)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: user.password,
      obscureText: true,
      decoration:
          InputDecoration(labelText: "Password:", icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget addressInputField() {
    return TextFormField(
      initialValue: user.address,
      decoration: InputDecoration(
          labelText: "Address:", icon: Icon(Icons.add_location_alt)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.address = newValue,
    );
  }

  Widget birthdateInputField() {
    return TextFormField(
      initialValue: user.birthdate,
      decoration: InputDecoration(
          labelText: "BirthDate:", icon: Icon(Icons.calendar_month_rounded)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.birthdate = newValue,
    );
  }

  Widget ageInputField() {
    return TextFormField(
      initialValue: user.age,
      decoration:
          InputDecoration(labelText: "Age:", icon: Icon(Icons.cake_rounded)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.age = newValue,
    );
  }

  Widget genderFormInput() {
    var initGen = "None";
    try {
      if (user.gender != null) {
        initGen = user.gender!;
      }
      ;
    } catch (e) {
      initGen = "None";
    }
    return DropdownButtonFormField(
        value: initGen,
        decoration: InputDecoration(labelText: "Gender", icon: Icon(Icons.man)),
        items: Configure.gender.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val),
          );
        }).toList(),
        onChanged: (value) {
          user.gender = value;
        },
        onSaved: (newValue) => user.gender);
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          addNewUser(user);
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(150, 130, 182, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        minimumSize: Size(150, 30),
      ),
      child: Text("Sign Up"),
    );
  }
}
