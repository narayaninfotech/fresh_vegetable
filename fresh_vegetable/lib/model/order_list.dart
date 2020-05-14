import 'package:freshvegetable/model/item.dart';

class OrderList {
  List<Item> item;

  OrderList({this.item});

  OrderList.fromJson(Map<String, dynamic> json) {
    if (json['Item'] != null) {
      item = new List<Item>();
      json['Item'].forEach((v) {
        item.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['Item'] = this.item.map((v) => v.toJson()).toList();
    }
    return data;
  }
}