import 'package:productmanage/models/config.dart';
import 'package:productmanage/models/users.dart';
import 'package:productmanage/allpage/accountform.dart';
import 'package:productmanage/allpage/accountinfo.dart';
import 'package:flutter/material.dart';
import 'package:productmanage/main.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  static const routeName = "/register";
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Widget mainBody = Container();
  List<Users> _userList = [];

  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.get(url);
    print(resp.body);
    setState(() {
      _userList = usersFromJson(resp.body);
      mainBody = showUser();
    });
    return;
  }

  Future<void> removeUsers(user) async {
    var url = Uri.http(Configure.server, "users/${user.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Manage"),
        backgroundColor: Color.fromRGBO(150, 130, 182, 1),
      ),
      drawer: const SideMenu(),
      body: mainBody,
    );
  }

  Widget showUser() {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        Users user = _userList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png'),
              backgroundColor: Colors.white,
            ),
            title: Text("${user.username}"),
            subtitle: Text("${user.email}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfo(),
                      settings: RouteSettings(arguments: user)));
            },
            trailing: IconButton(
              onPressed: () async {
                String result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountForm(),
                        settings: RouteSettings(arguments: user)));
                if (result == "refresh") {
                  getUsers();
                }
                ;
              },
              icon: Icon(Icons.edit),
            ),
          ),
          onDismissed: (direction) {
            removeUsers(user);
          },
          background: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}