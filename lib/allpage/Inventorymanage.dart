import 'package:flutter/material.dart';
import 'package:productmanage/allpage/inventoryinfo.dart';
import 'package:productmanage/allpage/inventoryform.dart';
import 'package:productmanage/main.dart';
import 'package:productmanage/models/products.dart';
import 'package:productmanage/models/config.dart';
import 'package:http/http.dart' as http;
import 'package:productmanage/models/users.dart';


class InventoryManage extends StatefulWidget {
  static const routeName = "/";
  const InventoryManage({super.key});

  @override
  State<InventoryManage> createState() => _InventoryManageState();
}

class _InventoryManageState extends State<InventoryManage> {
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

  Future<void> removeUsers(product) async {
    var url = Uri.http(Configure.server, "catalogs/${product.id}");
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
      title: const Text("Inventory Manage"),
      backgroundColor: Color.fromRGBO(150, 130, 182, 1),
    ),
    drawer: const SideMenu(),
    body: mainBody,
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        String result = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => InventoryForm()));
        if (result == "refresh") {
          getUsers();
        }
      },
      backgroundColor: Color.fromRGBO(150, 130, 182, 1),
      child: Icon(
        Icons.add_home_work_rounded,
        color: Colors.white,
      ),
    ),
  );
}


  Widget showUser() {
    return ListView.builder(
      itemCount: _productList.length,
      itemBuilder: (context, index) {
        Products product = _productList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
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
                      builder: (context) => InventoryInfo(),
                      settings: RouteSettings(arguments: product)));
            },
            trailing: IconButton(
              onPressed: () async {
                String result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InventoryForm(),
                        settings: RouteSettings(arguments: product)));
                if (result == "refresh") {
                  getUsers();
                }
                ;
              },
              icon: Icon(Icons.edit),
            ),
          ),
          onDismissed: (direction) {
            removeUsers(product);
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
