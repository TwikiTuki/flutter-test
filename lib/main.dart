import 'dart:io';
import 'themes/AppColors.dart';
import 'furniture/home_page.dart';
import 'cart/cart_page.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/model/Cart.dart';



void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var currentPage = 0;
  var cart = Cart();

  void setCurrentPage(var page) { this.currentPage = page; notifyListeners(); }
  int getCurrentPage() { return this.currentPage; }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyMaterialApp(),
    );
  }
}

class  MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override 
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    Widget page;

    switch(state.getCurrentPage()) {
      case (0):
        page = HomePage();
        break;
      case (1):
        page = HistoryPage();
        break;
      case (2):
        page = CartPage();
        break;
      default:
        throw Exception("INVALID PAGE");
    }

    return MaterialApp(
      title: "Nonna",
      theme: ThemeData(fontFamily: 'Manrope'),
      home: Scaffold(
        body: page,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black),)),
          child: BottomNavBar()
        ),
      )
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var state = context.watch<MyAppState>();
    const selectedIconColor = AppColors.nonnaRed; 
    const selectedBackgroundColor = AppColors.navSelectedBackground;
    return NavigationBar(
      backgroundColor:  AppColors.appBackground,
      indicatorColor: selectedBackgroundColor,
      onDestinationSelected:  (int index) {
        print("Selected destination $index");
        state.setCurrentPage(index);
      },
      selectedIndex: state.getCurrentPage(),
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: selectedIconColor,),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: selectedIconColor),
          icon: Icon(Icons.list),
          label: 'History',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.home, color: selectedIconColor),
          icon: Icon(Icons.shopping_cart_checkout_outlined),
          label: 'Cart',
        ),
      ],
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return(Text("HISTORY PAGE"));
  }
}
// 
// class CartPage extends StatelessWidget {
  // const CartPage({super.key});
// 
  // @override
  // Widget build(BuildContext context) {
    // return(Text("CART PAGE"));
  // }
// }