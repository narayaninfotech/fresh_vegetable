class GetImagesData {
  List<GetImages> getImages;

  GetImagesData({this.getImages});

  GetImagesData.fromJson(Map<String, dynamic> json) {
    if (json['getImages'] != null) {
      getImages = new List<GetImages>();
      json['getImages'].forEach((v) {
        getImages.add(new GetImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getImages != null) {
      data['getImages'] = this.getImages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetImages {
  String id;
  String imageUrl;
  String name;
  String kg;
  String price;

  GetImages({this.id, this.imageUrl, this.name, this.kg, this.price});

  GetImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    kg = json['kg'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['kg'] = this.kg;
    data['price'] = this.price;
    return data;
  }
}