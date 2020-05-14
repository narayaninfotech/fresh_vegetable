class SignInRequest {
  String email;
  String password;

  SignInRequest({
    this.email,
    this.password,
  });

  SignInRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  SignInRequest.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
