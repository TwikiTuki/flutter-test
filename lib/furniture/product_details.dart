import 'package:sdaf/main.dart';

import '/themes/AppColors.dart';
import '/model/Product.dart';
import '/model/Category.dart';
import '/furniture/filter.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const productTitleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkGrey, fontFamily: 'Manrope'); 
const productPriceStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.greyGreen);
const productDescriptionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.grey);

class ProductDetails extends StatelessWidget{
  var product = Product.defaultProduct();

  ProductDetails({super.key, product}){
    if (product != null)
      this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    print("current page ${appState.currentPage}");
    return Scaffold(
      body: Container(
        color: AppColors.appBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)
                  ),
                  child: Image.asset(fit: BoxFit.cover, this.product.image)
                ),
              ),
            ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(product.title, style: productTitleStyle),
                SizedBox(height: 15),
                Text(product.price.toString(), style: productPriceStyle),
                SizedBox(height: 15),
                Text(product.description, style: productDescriptionStyle),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      child: OutlinedButton( onPressed: (){appState.cart.addUnit(product);},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.nonnaRed ),
                          backgroundColor: AppColors.nonnaRed,
                        ),
                        child: Text("Añadir a la cesta", style: TextStyle(color: Colors.white)),
                      ),
                    )
                ]
                ),
                SizedBox(height: 25),
              ]
            )
          )
              
        ]
      ),
    )
    ); 

  } 
}