import '/themes/AppColors.dart';
import '/model/Product.dart';
import '/model/Category.dart';
import '/furniture/home_page.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProductFilter extends StatelessWidget {
  const ProductFilter({super.key});

  @override 
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Scaffold(
        backgroundColor: AppColors.appBackground, // semi-transparent
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15), 
            child: Column(
              children: [
                FilterNavbar(),
                HomeProductsCatalog(),
              ]
            ),
          ),
        ),
      )
    );
  }
}

class FilterNavbar extends StatelessWidget {
  const FilterNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final pageState = context.watch<HomePageState>();
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.grey, width:2), )), 
      child: Row(
        children: [

        GestureDetector(
          onTap: (){Navigator.of(context).pop();},
          child: Icon(Icons.arrow_back, color: AppColors.grey),
        ),
        SizedBox(width: 20),
        Expanded(child: TextField(
          onChanged: (value) {
            pageState.setWordFilter(value);
            // pageState.setCurrentProducts(Product.filteredProducts(pageState.categoryFilter, pageState.wordFilter));
            pageState.setCurrentProducts(Product.filteredProducts(Category.NO_FILTER, pageState.wordFilter));
          },
          cursorColor: AppColors.grey,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          )
        )),
      ]),
    );
  }
}