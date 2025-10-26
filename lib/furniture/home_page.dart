import 'dart:io';
import '/themes/AppColors.dart';
import '/model/Product.dart';
import '/model/Category.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageState extends ChangeNotifier {
  var wordFilter = "";
  var categoryFilter = "";
  var currentProducts = Product.productsList();

  String getWordFilter() {
    return this.wordFilter;
  }

  void setWordFilter(String wordFilter) {
    this.wordFilter = wordFilter;
    notifyListeners();
  }

  String getCategoryFilter() {
    return this.categoryFilter;
  }

  void setCategoryFilter(String categoryFilter) {
    this.categoryFilter = categoryFilter;
    notifyListeners();
  }

  List<Product> getCurrentProducts() {
    return this.currentProducts;
  }

  void setCurrentProducts(List<Product> currentProducts) {
    this.currentProducts = currentProducts;
    // this.currentProducts = Product.productsList();
    print("CURRENT PRODUCTS: ");
    for(var product in this.currentProducts) {
      print(product);
    }
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Container(
            padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15),
            color: AppColors.appBackground, //Color.fromARGB(255, 243, 243, 233),
            child: Column(
              children: [ 
                HomeNav(),
                SizedBox(height: 10,),
                HomeNavCatergories(categories: Category.ALL),
                SizedBox(height: 15,),
                HomeProductsCatalog(),
              ]
            )
      ),
    );
  }
}

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage("https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg"),
        ),
        // Text("Nonna"),
        Image.asset("assets/images/logo.png", height: 40,),
        GestureDetector(
          onTap: (){showDialog(
            barrierColor: Colors.transparent,
            useSafeArea: true,
            context: context,
            builder: (context){ return ProductFilter(); },
            barrierDismissible: true, // Tap outside to close
          );},
          child: Icon(Icons.search, size: 35,)
        ),
      ]
    );
  }
}

class HomeNavCatergories extends StatelessWidget {
  const HomeNavCatergories({super.key,  categories});
  final categories = Category.ALL;

  @override
  Widget build(BuildContext context) {
    final pageState = context.watch<HomePageState>();
    var ret = <Widget>[];
    print("categories:");
    for (var category in categories) {
      var buttonBackground = category == pageState.getCategoryFilter() ? AppColors.darkGrey : Colors.transparent;  
      var buttonTextColor = category == pageState.getCategoryFilter() ? Colors.white : AppColors.grey;  
      void onPressed(){
        pageState.setCategoryFilter(category);
        pageState.setCurrentProducts(Product.filteredProducts(category, ""));
      }
      print(" category: $category");
      ret.add(
        OutlinedButton( onPressed: (){onPressed();},
        style: OutlinedButton.styleFrom(side: BorderSide(color: AppColors.grey ), backgroundColor: buttonBackground),
        child: Text(category, style: TextStyle(color: buttonTextColor)),
      ));
      ret.add(SizedBox(width: 5));
    }
    // return SizedBox(height: 20, child: ListView(scrollDirection: Axis.horizontal, children: ret));
    return SizedBox(height: 20, child: ListView(scrollDirection: Axis.horizontal, children: ret));
  }
}

class HomeProductsCatalog extends StatelessWidget {
  // final products = const <String>["Todo", "Sillas", "Mesas", "Lamparas", "Armarios"];
  final products = Category.ALL;
  const HomeProductsCatalog({super.key,  products});

  @override
  Widget build(BuildContext context) {
    final pageState = context.watch<HomePageState>();
    print(Product.productsList()[0]);
    print(Product.productsList()[0].toString());
    var productsWidgets = <Widget>[];
    // for (var product in Product.productsList()) {
    if (pageState.getCurrentProducts().isEmpty){
        // padding: EdgeInsets.only(left: 50, right: 50), 
      return Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 50, right: 50), 
                  child: Image.asset('assets/images/flores.png')
                ),
                SizedBox(height: 20),
                Text("¡Encuentra la decoración perfecta para tu hogar!",
                  style: TextStyle(fontSize: 28, color: AppColors.hintText),
                  textAlign: TextAlign.center,
                )
              ]),
          ),
        );
    }
    for (var product in pageState.getCurrentProducts()) {
      productsWidgets.add(HomeProduct(product: product));
    }
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: productsWidgets,
      ),
    );
  }
}


class HomeProduct extends StatelessWidget {
  Product product = Product.defaultProduct();

  HomeProduct({product}) {
    this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    var price = this.product.price.toInt();
    // return Text("sdaf");
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.grey), )), 
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 7,
        children: [
          SizedBox(height: 300, width: double.infinity, child:
            ClipRRect( borderRadius: BorderRadius.circular(30) ,child: Image.asset(fit: BoxFit.cover, this.product.image)),
            // ClipRRect( borderRadius: BorderRadius.circular(30) ,child: Expanded(child: Image.asset(fit: BoxFit.cover, this.product.image)))
          ),   
          Text(style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkGrey, fontFamily: 'Manrope'), "${this.product.title}"),
          // Text(style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 61, 93, 82)), "${this.product.price}€"),
          Text(style: TextStyle(fontSize: 24, color: AppColors.greyGreen), "${this.product.price.toInt()}€"),
          Text(maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, color: AppColors.grey), "${this.product.description}"),
        ],
      ),
    );
  }
}

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
            pageState.setCurrentProducts(Product.filteredProducts(pageState.categoryFilter, pageState.wordFilter));
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

