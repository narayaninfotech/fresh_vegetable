class ForgotPasswordEmailRequest {
  String email;
  String otp;

  ForgotPasswordEmailRequest({
    this.email,
    this.otp,
  });

  ForgotPasswordEmailRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  ForgotPasswordEmailRequest.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    return data;
  }
}
