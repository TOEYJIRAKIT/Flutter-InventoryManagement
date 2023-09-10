import 'package:productmanage/models/config.dart';
import 'package:productmanage/models/users.dart';
import 'package:flutter/material.dart';
import 'package:productmanage/allpage/Inventorymanage.dart';
import 'package:productmanage/allpage/accountmanage.dart';
import 'package:productmanage/allpage/login.dart';
import 'package:productmanage/allpage/shoppage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Management',
      initialRoute: '/',
      routes: {
        '/': (context) => const InventoryManage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Account(),
        '/shoping': (context) => const ShoppingPage(),
      },
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "N/A";
    String accountEmail = "N/A";
    String accountUrl =
        "https://lh3.googleusercontent.com/a/AAcHTtf4Uly70tQrEq5OyhH5HMTT7k-voF20FCWFyQruDyav_Q=s360-c-no";
    Users user = Configure.login;
    if (user.id != null) {
      accountName = user.username!;
      accountEmail = user.email!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(150, 130, 182, 1),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_rounded),
            title: Text("Shop"),
            onTap: () {
              Navigator.pushNamed(context, ShoppingPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.warehouse),
            title: Text("Inventory"),
            onTap: () {
              Navigator.pushNamed(context, InventoryManage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts_rounded),
            title: Text("Account"),
            onTap: () {
              Navigator.pushNamed(context, Account.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Login"),
            onTap: () {
              Navigator.pushNamed(context, Login.routeName);
            },
          ),
        ],
      ),
    );
  }
}
