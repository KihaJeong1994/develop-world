import 'dart:html';

import 'package:develop_world/config/event_bus.dart';
import 'package:develop_world/config/sign_in_platform.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  kakaoSignin() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');
      window.localStorage['id'] = user.kakaoAccount!.email!;
      window.localStorage['signinPlatform'] = SigninPlatform.kakao.name;
      SingleEventBus.singleEventBus.fire(SignInEvent());
      navKey.currentState!.pushNamed(routeHome);
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'D.W.D  ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: '에 오신 걸 환영합니다!',
                      ),
                    ],
                  ),
                ),
                const Text('\n'),
                const Text(
                    'D.W.D는 개발자의 역량 발전과 미래를 위한 모든 정보를 취합하고 공유하려는 취지로 만든 사이트입니다. 여러분의 많은 참여를 부탁드립니다.'),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'D.W.D  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 25,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter valid mail id as abc@gmail.com'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your secure password'),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => kakaoSignin(),
                  child: SizedBox(
                    height: 50,
                    width: 250,
                    child: Image.asset(
                      'images/login/kakao_login_large_wide.png',
                      height: 50,
                      width: 250,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SignInEvent {}
