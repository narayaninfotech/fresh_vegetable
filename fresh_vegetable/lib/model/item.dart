class Item {
  int id;
  String image;
  String name;
  double kg;
  double price;

  Item(this.id, this.image, this.name, this.kg, this.price);

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    kg = json['kg'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['kg'] = this.kg;
    data['price'] = this.price;
    return data;
  }
}
