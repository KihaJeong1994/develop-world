import 'package:develop_world/config/event_bus.dart';
import 'package:develop_world/config/sign_in_platform.dart';
import 'package:develop_world/model/auth/sign_in_info.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/services/auth/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:seo/seo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final idController = TextEditingController();

  final passwordController = TextEditingController();

  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

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
      prefs.setString('id', user.kakaoAccount!.email!);
      prefs.setString('signinPlatform', SigninPlatform.kakao.name);
      // window.localStorage['id'] = user.kakaoAccount!.email!;
      // window.localStorage['signinPlatform'] = SigninPlatform.kakao.name;
      SingleEventBus.singleEventBus.fire(SignInEvent());
      context.push(routeHome);
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
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
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('\n'),
                Seo.text(
                  text:
                      'D.W.D는 개발자의 역량 발전과 미래를 위한 모든 정보를 취합하고 공유하려는 취지로 만든 사이트입니다. 여러분의 많은 참여를 부탁드립니다.',
                  child: const Text(
                      'D.W.D는 개발자의 역량 발전과 미래를 위한 모든 정보를 취합하고 공유하려는 취지로 만든 사이트입니다. 여러분의 많은 참여를 부탁드립니다.'),
                ),
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'id',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your secure password'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push(routeSignUp);
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '비밀번호 찾기',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      AuthApiService.signIn(SignInInfo(
                        userId: idController.text,
                        password: passwordController.text,
                      )).then((authResponse) {
                        prefs.setString('id', authResponse.userId);
                        prefs.setString('token', authResponse.token);
                        // window.localStorage['id'] = authResponse.userId;
                        // window.localStorage['token'] = authResponse.token;
                        SingleEventBus.singleEventBus.fire(SignInEvent());
                        context.push(routeHome);
                      }).onError((error, stackTrace) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('로그인 정보가 틀렸습니다!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => context.pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    style: TextButton.styleFrom(
                        // backgroundColor: Colors.blue,
                        ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () => kakaoSignin(),
                //   child: SizedBox(
                //     height: 50,
                //     width: 250,
                //     child: Image.asset(
                //       'images/login/kakao_login_large_wide.png',
                //       height: 50,
                //       width: 250,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SignInEvent {}
