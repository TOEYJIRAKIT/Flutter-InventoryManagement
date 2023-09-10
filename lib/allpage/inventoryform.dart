import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:productmanage/models/config.dart';
import 'package:productmanage/models/users.dart';
import 'package:productmanage/models/products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key});

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  final _formkey = GlobalKey<FormState>();
  //Users user = Users();
  // late Users user;
  late Products product;
  // TextEditingController _dateController = TextEditingController();

  Future<void> addNewUser(product) async {
    var url = Uri.http(Configure.server, "catalogs");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(product.toJson()));
    var rs = usersFromJson("[${resp.body}]");

    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  Future<void> updateData(product) async {
    var url = Uri.http(Configure.server, "catalogs/${product.id}");
    var resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(product.toJson()));
    var rs = usersFromJson("[${resp.body}]");

    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    try {
      product = ModalRoute.of(context)!.settings.arguments as Products;
      print(product.itemName);
    } catch (e) {
      product = Products();
    }
    ;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Inventory Form"),
          backgroundColor: Color.fromRGBO(150, 130, 182, 1)),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imagesInputField(),
              pnameInputField(),
              detailInputField(),
              priceInputField(),
              ratingInputField(),
              dateInputField(),
              // ratingInputField(),
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

  Widget imagesInputField() {
    return TextFormField(
      initialValue: product.images,
      decoration:
          InputDecoration(labelText: "Images URL:", icon: Icon(Icons.link)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => product.images = newValue,
    );
  }

  Widget pnameInputField() {
    return TextFormField(
      initialValue: product.itemName,
      decoration: InputDecoration(
          labelText: "Product Name:", icon: Icon(Icons.shopping_cart)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => product.itemName = newValue,
    );
  }

  Widget priceInputField() {
    return TextFormField(
      initialValue: product.price,
      decoration: InputDecoration(
          labelText: "Price:", icon: Icon(Icons.price_change_rounded)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => product.price = newValue,
    );
  }

  Widget detailInputField() {
    return TextFormField(
      initialValue: product.detail,
      decoration:
          InputDecoration(labelText: "Detail:", icon: Icon(Icons.description)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => product.detail = newValue,
    );
  }

  Widget dateInputField() {
    String? initialDate;

    if (product.date != null) {
      initialDate = DateFormat('yyyy-MM-dd').format(product.date!);
    } else {
      initialDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }

    return TextFormField(
      initialValue: initialDate,
      decoration: InputDecoration(
        labelText: "Date:",
        icon: Icon(Icons.edit_calendar_rounded),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) {
        if (newValue != null) {
          product.date = DateFormat('yyyy-MM-dd').parse(newValue);
        }
      },
    );
  }

  Widget ratingInputField() {
    var initRating = "0.0";
    try {
      if (product.rating != null) {
        initRating = product.rating!.toString();
      }
      ;
    } catch (e) {
      initRating = "0.0";
    }

    return DropdownButtonFormField<String>(
      value: initRating,
      decoration: InputDecoration(
          labelText: "Rating", icon: Icon(Icons.star_half_rounded)),
      items: ConfigureTwo.rating.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          product.rating = double.tryParse(value);
        }
      },
      onSaved: (newValue) {
        if (newValue != null) {
          product.rating = double.tryParse(newValue);
        }
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(product.toJson().toString());
          // addNewUser(product);
          if (product.id == null) {
            addNewUser(product);
          } else {
            updateData(product);
          }
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
      child: Text("Save"),
    );
  }
}
