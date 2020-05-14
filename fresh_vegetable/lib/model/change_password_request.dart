class ChangePasswordRequest {
  String email;
  String oldPassword;
  String newPassword;

  ChangePasswordRequest({
    this.email,
    this.oldPassword,
    this.newPassword
  });

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
  }

  ChangePasswordRequest.withError(String s) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
