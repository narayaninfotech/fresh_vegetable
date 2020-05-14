class SignUpResponse {
  String result;

  SignUpResponse({this.result});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  SignUpResponse.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}