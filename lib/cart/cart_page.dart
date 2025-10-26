import 'dart:io';
import 'package:sdaf/furniture/home_page.dart';
import 'package:sdaf/main.dart';
import 'package:sdaf/model/Cart.dart';

import '/themes/AppColors.dart';
import '/model/Product.dart';
import '/model/Category.dart';
import '/furniture/filter.dart';
import '../furniture/product_details.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    var products = <Widget>[];
    
    for (var prod in appState.cart.items.values){
      // print("ADDING PRODUCT $prod");
      // products.add(Text("${prod}"));
      products.add(CartEntryWidget(entry: prod));
      products.add(SizedBox(height: 20));
      
    }
          // return Container(child: ListView(
    return Column(
      children: [
        HomeNav(search: false,),
        SizedBox(height: 20),
        Expanded(
          child: ListView( 
            scrollDirection: Axis.vertical,
            children: products,
          ),
        )
      ],
    );
  }
}

class CartEntryWidget extends StatelessWidget {
  final CartEntry entry;

  const CartEntryWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context){
    var product = entry.product;
    return Row(
      children: [
        SizedBox(width: 200, child: Image.asset(entry.product.image)),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(children: [Text(product.title), Text("${product.price.toString()}€")])
            ),
            Row(
              children: [
                Text("${entry.ammount}"),
                Icon(Icons.delete),
              ],
            )
          ],
        )

      ]
    );
  }
}