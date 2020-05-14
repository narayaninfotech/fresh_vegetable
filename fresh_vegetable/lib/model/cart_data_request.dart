class CartDataRequest {
  String userId;
  String orderList;
  String paymentId;
  String orderId;
  String amount;
  String address;

  CartDataRequest({
    this.userId,
    this.orderList,
    this.paymentId,
    this.orderId,
    this.amount,
    this.address
  });

  CartDataRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    orderList= json['orderList'];
    paymentId = json['paymentId'];
    orderId = json['OrderId'];
    amount = json['amount'];
    address = json['address'];
  }

  CartDataRequest.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['orderList'] = this.orderList;
    data['paymentId'] = this.paymentId;
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['address'] = this.address;
    return data;
  }
}
