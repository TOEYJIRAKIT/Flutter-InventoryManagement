import 'package:flutter/material.dart';
import 'package:productmanage/allpage/shopinfo.dart';
import 'package:productmanage/main.dart';
import 'package:productmanage/models/products.dart';
import 'package:productmanage/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:productmanage/models/users.dart';
import 'dart:math';

class ShoppingPage extends StatefulWidget {
  static const routeName = "/shoping";
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

    final Random random = Random();
    final int red = random.nextInt(256);
    final int green = random.nextInt(256);
    final int blue = random.nextInt(256);

    // Create a Color object with the random color values
    final backgroundColor = Color.fromRGBO(red, green, blue, 1);


class _ShoppingPageState extends State<ShoppingPage> {
  Widget mainBody = Container();
  List<Products> _productList = [];

  Future<void> getUsers() async {
    var url = Uri.http(Configure.server, "catalogs");
    var resp = await http.get(url);
    print(resp.body);
    setState(() {
      _productList = productsFromJson(resp.body);
      mainBody = showUser();
    });
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
        title: const Text("Shopping"),
        backgroundColor: backgroundColor,
      ),
      drawer: const SideMenu(),
      body: mainBody,
    );
  }

  Widget showUser() {
    return ListView.builder(
      itemCount: _productList.length,
      itemBuilder: (context, index) {
        Products product = _productList[index];
        return Card(
          key: UniqueKey(),
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  "${product.images}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text("${product.itemName}"),
            subtitle: Text("\$${product.price}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShoppingInfo(),
                      settings: RouteSettings(arguments: product)));
            },
            trailing: Icon(Icons.shopping_cart_rounded),
          ),
        );
      },
    );
  }
}
