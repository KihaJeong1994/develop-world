import 'package:develop_world/model/user.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/services/auth/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Container(
            width: 420,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.length < 4) {
                            return "4글자 이상 입력해주세요";
                          }
                          return null;
                        },
                        controller: idController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'id',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return '이메일은 필수사항입니다.';
                          }

                          if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val)) {
                            return '잘못된 이메일 형식입니다.';
                          }

                          return null;
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return '비밀번호는 필수사항입니다.';
                          }

                          if (val.length < 8) {
                            return '8자 이상 입력해주세요!';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AuthApiService.register(User(
                                userId: idController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              )).then((value) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('회원가입에 성공하였습니다!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            context.push(routeHome),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                                context.push(routeHome);
                              }).onError((error, stackTrace) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('정보를 정확히 입력해주세요!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => context.pop(),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
