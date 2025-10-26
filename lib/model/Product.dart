import 'package:sdaf/model/Category.dart';

class Product{
  String image = "";
  String title = "";
  double price = 0.0; // TODO would be better to user currency format
  String description = "";
  String sticker = "";
  List<String> category = <String>[Category.NO_FILTER];

  Product({title, image, price = 0.0, description, sticker, category}) {
    this.image = image;
    this.title = title;
    this.price = price;
    this.description = description;
    this.sticker = sticker;
    for (var cat in category){
      this.category.add(cat);
    }
  }

  static Product defaultProduct() {
    return new Product(
        title: "Title",
        image: "https://www.ikea.com/es/es/images/products/adde-silla-blanco__0872092_pe716742_s5.jpg?f=xl",
        price: -1.0,
        description: "description",
        sticker: "",
        category: [],
      );

  }

  String toString() {
    var categories = "";
    for (var category in this.category) {
      categories += "${category}, ";
    }
    return ("title: $title, image: $image, price: $price, description: $description, sticker: $sticker, category: $categories");

  }

  static List<Product> filteredProducts(String categorie, String filterString){
    var result = <Product>[];
    var products = Product.productsList();
    for (var product in products) {
      print("Filtering ${product.title} with $categorie, $filterString");
      if (categorie != Category.NO_FILTER && !product.category.contains(categorie)){
        print("rejected ${product.title}");
        continue;
      }
      if ( filterString != "" && !product.title.contains(filterString)){
        print("rejecteddd ${product.title}");
        continue;
      }
      print("accepting ${product.title}");
      result.add(product);
    }
    return result;

  }

  List<String> getCategory() {
    return this.category;
  }

  void addCategory(String category) {
    if (this.category.contains(category))
      return ;
    this.category.add(category);
  }

  void removeCategory(String cateogry) {
    if (cateogry == Category.NO_FILTER)
      return ;
    this.category.remove(category);
  }

  static productsList() {
    return [
      new Product(
        title: "Sofá Modular Kori",
        image: "assets/images/sofa-modular-kori.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
        category: [Category.sofas],
      ),
      new Product(
        title: "Sillas comedor Twiki",
        image: "assets/images/silla-comedor-twiki.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
        category: [Category.sillas],
      ),
      new Product(
        title: "Mesa comedor longa",
        image: "assets/images/mesa-comedor-longa.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
        category: [Category.mesas],
      ),
      new Product(
        title: "Mesa koglen",
        image: "assets/images/mesa-koglen.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
        category: [Category.mesas],
      ),
      new Product(
        title: "Mesita uxiliar kaopa",
        image: "assets/images/mesita-auxiliar-kaopa.png",
        price: 100.00,
        description: "El sofá Modular Kori redefine la versatilidad y el control en el mobiliaro moderno. Con su diseño modular, permite mútiples configuraciones para daptarse perfectamenta a tu espacio y necesidades. Su tapiceria de alta calidad, aporta un toque contemporàneo.",
        sticker: "",
        category: [Category.mesitas],
      ),
    ];
  }
}