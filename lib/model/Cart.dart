import 'package:sdaf/model/Product.dart';

class CartEntry {
  var ammount = 0;
  var product = Product.defaultProduct();
  
  CartEntry(var ammount, var product) {
    this.ammount = ammount;
    this.product = product;
  }

  Product getProduct(){
    return this.product;
  }
} 

class Cart {
  var items = Map<String, CartEntry>();

  void _addProduct(product) {
    if (this.items.containsKey(product.title))
      return;
    this.items[product.title] = CartEntry(0, product);
  }

  void removeAllProductUnits(product) {
    this.items.remove(product.title);
  }

  void addUnit(product) {
    this._addProduct(product);
    this.items[product.title]?.ammount += 1;
  }

  void removeUnit(product) {
    var key = product.title;
    if (this.items[key] == null )
      return;
    this.items[product.title]?.ammount -= 1;
    if (this.items[key]?.ammount == 0)
      this.items.remove(key);
  }
}