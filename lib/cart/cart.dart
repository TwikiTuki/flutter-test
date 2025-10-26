import 'dart:io';
import 'package:sdaf/main.dart';

import '/themes/AppColors.dart';
import '/model/Product.dart';
import '/model/Category.dart';
import '/furniture/filter.dart';
import '/furniture/productDetails.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    return Text("cart page");
  }

}