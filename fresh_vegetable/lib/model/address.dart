class Address {
  String address;
  String city;
  String zip_code;
  String landmark;

  Address(this.address, this.city, this.zip_code, this.landmark);

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    zip_code = json['zip_code'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip_code'] = this.zip_code;
    data['landmark'] = this.landmark;
    return data;
  }
}
