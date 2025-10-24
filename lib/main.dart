import 'dart:io';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nonna",
      theme: ThemeData(),
      home: Scaffold(body: HomePage())
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return HomeNav();
  }
}

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});
  @override
  Widget build(BuildContext context) {
  return Container(
          child:  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"),
                  ),
                  Text("Nonna"),
                  Icon(Icons.search)
                ]
              ),
              SizedBox(height: 10,),
              HomeNavCatergories(categories: ["Sillas", "Mesas", "Lamparas"]),
              HomeProductsCatalog(),
            ]
          ),
        );
  }
}

class HomeNavCatergories extends StatelessWidget {
  final categories = const <String>["Todo", "Sillas", "Mesas", "Lamparas", "Armarios"];
  const HomeNavCatergories({super.key,  categories});
  void onPressed(){}
  @override
  Widget build(BuildContext context) {
    var ret = <Widget>[];
    print("categories:");
    for (var category in categories) {
      print(" category: $category");
      ret.add(OutlinedButton(onPressed: onPressed, child: Text(category)));
    }
    return SizedBox(height: 20, child: ListView(scrollDirection: Axis.horizontal, padding: EdgeInsets.only(left: 5), children: ret));
  }
}

class HomeProductsCatalog extends StatelessWidget {
  final products = const <String>["Todo", "Sillas", "Mesas", "Lamparas", "Armarios"];
  const HomeProductsCatalog({super.key,  products});

  @override
  Widget build(BuildContext context) {
    print(Product.productsList()[0]);
    print(Product.productsList()[0].toString());
    return Expanded(
      child: ListView(
        children: [
          HomeProduct(product: Product.productsList()[0]),
          // HomeProduct(product: Product.productsList()[0]),
          // HomeProduct(product: Product.productsList()[0]),
          // HomeProduct(product: Product.productsList()[0]),
        ],
      ),
    );
  }
}

class Product{
  String image = "";
  String title = "";
  double price = 0.0; // TODO would be better to user currency format
  String description = "";
  String sticker = "";

  Product({image, title, price, description, sticker}) {
    this.image = image;
    this.title = title;
    this.price = price;
    this.description = description;
    this.sticker = sticker;
  }

  static Product defaultProduct() {
    return new Product(
        title: "Title",
        image: "https://www.ikea.com/es/es/images/products/adde-silla-blanco__0872092_pe716742_s5.jpg?f=xl",
        price: -1,
        description: "description",
        sticker: "",
      );

  }

  String toString() {
    return ("title: $title, image: $image, price: $price, description: $description, sticker: $sticker, ");

  }

  static productsList() {
    return [
      new Product(
        title: "Sillas comedor",
        image: "https://www.ikea.com/es/es/images/products/adde-silla-blanco__0872092_pe716742_s5.jpg?f=xl",
        price: 100,
        description: "Buenas bonitas i baratas. Corre que se acaban",
        sticker: "",
      ),
    ];
  }
}

class HomeProduct extends StatelessWidget {
  Product product = Product.defaultProduct();
  HomeProduct({product}) {
    this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    var price = this.product.price;
    // return Text("sdaf");
    return Flex(
      direction: Axis.vertical,
      children: [Flexible( flex: 0, fit: FlexFit.loose,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [Expanded(child: Image.network("https://www.ikea.com/es/es/images/products/adde-silla-blanco__0872092_pe716742_s5.jpg?f=xl"))]),    
            Text("sdaf"),
            Text("sdaf"),
            Text("sdaf"),
            Text("sdaf"),
          ],
        ),
      )],
    );
  }
}