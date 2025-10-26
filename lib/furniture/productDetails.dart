import 'package:sdaf/main.dart';

import '/themes/AppColors.dart';
import '/model/Product.dart';
import '/model/Category.dart';
import '/furniture/filter.dart';
import '/furniture/home_page.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget{
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    print("current page ${appState.currentPage}");
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Text("PRODUCT DETAILS")
        ]
      ),
    ); 

  } 
}