class TokenResponse {
  String? token;
  String? refreshToken;

  TokenResponse({this.token, this.refreshToken});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = token;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
