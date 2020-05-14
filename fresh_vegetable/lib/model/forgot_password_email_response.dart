class ForgotPasswordEmailResponse {
  String result;

  ForgotPasswordEmailResponse({this.result});

  ForgotPasswordEmailResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}