import 'dart:convert';

import 'package:develop_world/model/auth/auth_response.dart';
import 'package:develop_world/model/auth/sign_in_info.dart';
import 'package:develop_world/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthApiService {
  static final baseUrl = '${dotenv.env['SITE_URL']}/api/auth';

  static Future<void> register(User user) async {
    var url = '$baseUrl/signup';
    final response = await http.post(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: jsonEncode(user
          .toJson()), // jsonEncode(lectureReview) fails because cannot turn to json directly
    );
    if (response.statusCode != 201) {
      throw Error();
    }
  }

  static Future<AuthResponse> signIn(SignInInfo signInInfo) async {
    var url = '$baseUrl/signin';
    final response = await http.post(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: jsonEncode(signInInfo
          .toJson()), // jsonEncode(lectureReview) fails because cannot turn to json directly
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return AuthResponse.fromJson(json);
    }
    throw Error();
  }
}
