class TokenRequest {
  String? username;
  String? password;

  TokenRequest({
    this.username,
    this.password,
  });

  TokenRequest.fromJson(Map<String, dynamic> json) {
    username = json['phone_number'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.username;
    data['password'] = this.password;

    return data;
  }
}
