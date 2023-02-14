class AuthResponse {
  String userId;
  String token;

  AuthResponse.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        token = json['token'];
}
