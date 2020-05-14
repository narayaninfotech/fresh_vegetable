import 'package:freshvegetable/model/address.dart';
import 'package:freshvegetable/model/item.dart';

class AddressList {
  List<Address> addressItem;

  AddressList({this.addressItem});

  AddressList.fromJson(Map<String, dynamic> json) {
    if (json['Address'] != null) {
      addressItem = new List<Address>();
      json['Address'].forEach((v) {
        addressItem.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressItem != null) {
      data['Address'] = this.addressItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}