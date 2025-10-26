import 'dart:io';
import 'themes/AppColors.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  var currentPage = 0;

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
  MyMaterialApp({super.key});

  @override 
  Widget build(BuildContext context) {
    var state = context.watch<MyAppState>();
    var page;

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
      theme: ThemeData(),
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
    const selectedBackgroundColor = Color.fromARGB(255, 233, 233, 222);
    return NavigationBar(
      backgroundColor: Color.fromARGB(255, 243, 243, 233),
      indicatorColor: Color.fromARGB(255, 233, 233, 222),
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
          padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15),
          color: Color.fromARGB(255, 243, 243, 233),
          child: Column(
            children: [
              Row(
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
                      context: context,
                      builder: (context){ return ProductFilter(); },
                      barrierDismissible: true, // Tap outside to close
                    );},
                    child: Icon(Icons.search, size: 35,)
                  ),
                ]
              ),
              
              SizedBox(height: 10,),
              HomeNavCatergories(categories: ["Sillas", "Mesas", "Lamparas"]),
              SizedBox(height: 15,),
              HomeProductsCatalog(),
            ]
          ),
        );
  }
}

class ProductFilter extends StatelessWidget {
  const ProductFilter({super.key});

  @override 
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return true to allow closing with back button
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8), // semi-transparent
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('This is a full-screen popup!'),
          ),
        ),
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
      ret.add(
        OutlinedButton( onPressed: onPressed,
        style: OutlinedButton.styleFrom(side: BorderSide(color: Color.fromARGB(255, 86, 86, 86))),
        child: Text(category, style: TextStyle(color: Color.fromARGB(255, 86, 86, 86))),
      ));
      ret.add(SizedBox(width: 5));
    }
    // return SizedBox(height: 20, child: ListView(scrollDirection: Axis.horizontal, children: ret));
    return SizedBox(height: 20, child: ListView(scrollDirection: Axis.horizontal, children: ret));
  }
}

class HomeProductsCatalog extends StatelessWidget {
  final products = const <String>["Todo", "Sillas", "Mesas", "Lamparas", "Armarios"];
  const HomeProductsCatalog({super.key,  products});

  @override
  Widget build(BuildContext context) {
    print(Product.productsList()[0]);
    print(Product.productsList()[0].toString());
    var productsWidgets = <Widget>[];
    for (var product in Product.productsList()) {
      productsWidgets.add(HomeProduct(product: product));
    }
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: productsWidgets,
        // children: [Text("Sdaf"),
        // HomeProduct(product: Product.productsList()[0]),
        // HomeProduct(product: Product.productsList()[1])
        // ],
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

  Product({title, image, price = 0.0, description, sticker}) {
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
        price: -1.0,
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
        title: "Sofá Modular Kori",
        image: "assets/images/sofa-modular-kori.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
      ),
      new Product(
        title: "Sillas comedor Twiki",
        image: "assets/images/silla-comedor-twiki.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
      ),
      new Product(
        title: "Mesa comedor longa",
        image: "assets/images/mesa-comedor-longa.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
      ),
      new Product(
        title: "Mesa koglen",
        image: "assets/images/mesa-koglen.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
      ),
      new Product(
        title: "Mesita uxiliar kaopa",
        image: "assets/images/mesita-auxiliar-kaopa.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
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
    print("initlializng HomeProduct with product: ${this.product.toString()}");
    var price = this.product.price.toInt();
    // return Text("sdaf");
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black), )), 
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
          Text(style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 34, 34, 34), fontFamily: 'Manrope'), "${this.product.title}"),
          // Text(style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 61, 93, 82)), "${this.product.price}€"),
          Text(style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 61, 93, 82)), "${this.product.price.toInt()}€"),
          Text(maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 86, 86, 86)), "${this.product.description}"),
        ],
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return(Text("ISTORY PAGE"));
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return(Text("CART PAGE"));
  }
}