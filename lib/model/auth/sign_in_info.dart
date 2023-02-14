class SignInInfo {
  String userId, password;
  SignInInfo({
    required this.userId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'password': password,
    };
  }
}
