class Item {
  String name;
  double price;

  Item({required this.name, required this.price});

  Map<String, dynamic> toJson() => {'name': name, 'price': price};
  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(name: json['name'], price: json['price']);
}
