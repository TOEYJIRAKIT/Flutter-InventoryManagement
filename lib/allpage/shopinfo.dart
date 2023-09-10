import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:productmanage/models/products.dart';
// import 'dart:math';

class ShoppingInfo extends StatefulWidget {
  @override
  _ShoppingInfoState createState() => _ShoppingInfoState();
}


    // final Random random = Random();
    // final int red = random.nextInt(256);
    // final int green = random.nextInt(256);
    // final int blue = random.nextInt(256);

    // // Create a Color object with the random color values
    // final backgroundColor = Color.fromRGBO(red, green, blue, 1);

class _ShoppingInfoState extends State<ShoppingInfo> {
  int quantity = 0;
  double total = 0.0; 


  void incrementQuantity() {
    setState(() {
      quantity++;
      calculateTotal();
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        calculateTotal();
      });
    }
  }

  void calculateTotal() {
    var product = ModalRoute.of(context)!.settings.arguments as Products;
    final price = double.tryParse(product.price ?? '0.0') ??
        0.0; 
    setState(() {
      total = quantity.toDouble() * price;
    });
  }

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Products;
    double rating = product.rating ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Info"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Image.network("${product.images}", fit: BoxFit.cover),
              ),
              ListTile(
                title: Text("Product Name"),
                subtitle: Text("${product.itemName}"),
              ),
              ListTile(
                title: Text("Detail"),
                subtitle: Text("${product.detail}"),
              ),
              ListTile(
                title: Text("Price"),
                subtitle: Text("\$${product.price}"),
              ),
              ListTile(
                title: Text("Rating"),
                subtitle: RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) => print(value),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: Color.fromARGB(255, 230, 229, 229),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: decrementQuantity,
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: incrementQuantity,
                    ),
                    SizedBox(width: 110),
                    Column(
                      children: [
                        Text(
                          "Total: \$${total.toStringAsFixed(2)}",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ) 
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                child: submitButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(150, 130, 182, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart), // Shopping cart icon
          SizedBox(width: 8),
          Text("Add to Cart"),
        ],
      ),
    );
  }
}
