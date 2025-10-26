class Cart {
  var items = Map<String, int>();

  void _addProduct(product) {
    if (this.items.containsKey(product.title))
      return;
    this.items[product.title] = 0;
  }

  void removeAllProductUnits(product) {
    this.items.remove(product.title);
  }

  void addUnit(product) {
    this._addProduct(product);
    this.items[product.title] = (this.items[product.title] ?? 0) + 1;
  }

  void removeUnit(product) {
    var key = product.title;
    if (this.items[key] == null )
      return;
    this.items[key] = (this.items[key] ?? 0) - 1;
    if (this.items[key] == 0)
      this.items.remove(key);
  }
}