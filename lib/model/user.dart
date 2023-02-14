class User {
  String userId, email, password;
  User({
    required this.userId,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'password': password,
    };
  }
}
