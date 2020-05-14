class ForgotPasswordResetRequest {
  String email;
  String password;

  ForgotPasswordResetRequest({
    this.email,
    this.password,
  });

  ForgotPasswordResetRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  ForgotPasswordResetRequest.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
