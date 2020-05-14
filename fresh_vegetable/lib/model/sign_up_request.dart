class SignUpRequest {
  String fullname;
  String email;
  String password;

  SignUpRequest({
    this.fullname,
    this.email,
    this.password,
  });

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
  }

  SignUpRequest.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
