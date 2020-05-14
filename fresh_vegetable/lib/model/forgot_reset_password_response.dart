class ForgotPasswordResetResponse {
  String result;

  ForgotPasswordResetResponse({this.result});

  ForgotPasswordResetResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}