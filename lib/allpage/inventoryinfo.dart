import 'package:productmanage/models/products.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';


class InventoryInfo extends StatelessWidget {
  const InventoryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var product = ModalRoute.of(context)!.settings.arguments as Products;
    double rating = product.rating ?? 0.0;

    
    String formattedDate = product.date != null
    ? DateFormat('yyyy-MM-dd').format(product.date!)
    : '';

    final Random random = Random();
    final int red = random.nextInt(256);
    final int green = random.nextInt(256);
    final int blue = random.nextInt(256);

    // Create a Color object with the random color values
    final backgroundColor = Color.fromRGBO(red, green, blue, 1);
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory Info"),
        backgroundColor: backgroundColor
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
                title: Text("Datail"),
                subtitle: Text("${product.detail}"),
              ),
              ListTile(
                title: Text("Price"),
                subtitle: Text("\$${product.price}"),
              ),
              ListTile(
                title: Text("Rating"),
                // Use RatingBar.builder to display the rating bar
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
              ListTile(
                title: Text("Date"),
                subtitle: Text(formattedDate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
