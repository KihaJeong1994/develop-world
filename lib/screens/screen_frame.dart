import 'package:develop_world/config/event_bus.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/screens/account/sign_in_screen.dart';
import 'package:develop_world/widgets/common/navigation_bar_web.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenFrame extends StatefulWidget {
  final Widget child;
  const ScreenFrame({
    super.key,
    required this.child,
  });

  @override
  State<ScreenFrame> createState() => _ScreenFrameState();
}

class _ScreenFrameState extends State<ScreenFrame> {
  // String? id = window.localStorage['id'];
  // bool isSignIn = window.localStorage['id'] != null;
  String? id;
  bool isSignIn = false;
  late SharedPreferences prefs;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    isSignIn = prefs.getString('token') != null;
    setState(() {});
  }

  void logOut() {
    // window.localStorage.remove('id');
    // window.localStorage.remove('token');
    prefs.remove('id');
    prefs.remove('token');

    setState(() {
      isSignIn = false;
      id = null;
    });
    // switch (window.localStorage['signinPlatform']) {
    //   case 'kakao':
    //     kakaoLogOut();
    //     break;
    //   default:
    // }
  }

  void kakaoLogOut() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }

  @override
  void initState() {
    super.initState();
    SingleEventBus.singleEventBus.on<SignInEvent>().listen((event) {
      setState(() {
        isSignIn = true;
        // id = window.localStorage['id'];
        id = prefs.getString('id');
      });
    });
    SingleEventBus.singleEventBus.on<SignOutEvent>().listen((event) {
      setState(() {
        logOut();
      });
    });
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.accessibility_new_rounded),
          //   onPressed: () {
          //     context.push(routeHome);
          //   },
          // ),
          actions: <Widget>[
            if (id != null)
              Align(
                alignment: Alignment.center,
                child: Text(
                  '$id님 환영합니다',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            TextButton.icon(
              onPressed: () {
                if (isSignIn) {
                  logOut();
                }
                context.push(routeSignIn);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              icon: const Icon(Icons.login),
              label: isSignIn ? const Text('로그아웃') : const Text('로그인'),
            )
          ],
          title: TextButton(
            onPressed: () {
              context.push(routeHome);
            },
            child: const Text(
              'D.W.D',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: false,
        ),
        body: Row(
          children: [
            const SafeArea(child: NavigationBarWeb()),
            Expanded(child: widget.child),
          ],
        ));
  }
}

class SignOutEvent {}
