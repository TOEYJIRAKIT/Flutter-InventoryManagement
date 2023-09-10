import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:productmanage/allpage/Inventorymanage.dart';
import 'package:productmanage/allpage/registerform.dart';
import 'package:productmanage/models/config.dart';
import 'package:productmanage/models/users.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();
  bool isLoading = false;

  Future<void> login(Users user) async {
    setState(() {
      isLoading = true;
    });

    try {
      var params = {"email": user.email, "password": user.password};
      var url = Uri.http(Configure.server, "users", params);
      var resp = await http.get(url);
      print(resp.body);
      List<Users> login_result = usersFromJson(resp.body);
      print(login_result.length);
      if (login_result.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Username or password invalid")))
          ..closed.then((reason) {
            setState(() {
              isLoading = false;
            });
          });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              const SnackBar(content: Text('Login successful')),
            )
            .closed
            .then((reason) {
          if (reason == SnackBarClosedReason.timeout) {
            Configure.login = login_result[0];
            Navigator.pushNamed(context, InventoryManage.routeName);
          }
          setState(() {
            isLoading = false;
          });
        });
      }
    } catch (error) {
      print("Error: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Color.fromRGBO(150, 130, 182, 1),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(25.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appLogo(),
                  Container(
                    margin: EdgeInsets.only(
                        right: 45.0), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "For Admin",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(150, 130, 182, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  emailInputField(),
                  SizedBox(
                    height: 15.0,
                  ),
                  passwordInputField(),
                  SizedBox(
                    height: 15.0,
                  ),
                  submitButton(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      registerLink()
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget appLogo() {
    return const Text(
      "EVERYSHOP",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: 10.0),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "a@test.com",
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        if (!EmailValidator.validate(value)) {
          return "It is not an email format";
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "1q2w3e4r",
      obscureText: true,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          login(user);
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(150, 130, 182, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        minimumSize: Size(200, 30),
      ),
      child: Text("Login"),
    );
  }

  Widget registerLink() {
    return InkWell(
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(150, 130, 182, 1),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterForm()),
        );
      },
    );
  }
}
