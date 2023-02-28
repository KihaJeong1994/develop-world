import 'package:develop_world/config/kr_custom_messages.dart';
import 'package:develop_world/routes/routes.dart';
import 'package:develop_world/screens/account/sign_in_screen.dart';
import 'package:develop_world/screens/account/sign_up_screen.dart';
import 'package:develop_world/screens/contacts/contact_detail.dart';
import 'package:develop_world/screens/contacts/contact_write.dart';
import 'package:develop_world/screens/contacts/contacts_list.dart';
import 'package:develop_world/screens/home/home_screen.dart';
import 'package:develop_world/screens/lecture/lecture_detail.dart';
import 'package:develop_world/screens/lecture/lecture_list.dart';
import 'package:develop_world/screens/screen_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:go_router/go_router.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: routeHome,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: ScreenFrame(child: HomeScreen()));
      },
      builder: (context, state) => const ScreenFrame(child: HomeScreen()),
    ),
    GoRoute(
      path: routeSignIn,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
            child: ScreenFrame(child: SignInScreen()));
      },
      builder: (context, state) => const ScreenFrame(child: SignInScreen()),
    ),
    GoRoute(
      path: routeSignUp,
      pageBuilder: (context, state) {
        return NoTransitionPage(child: ScreenFrame(child: SignUpScreen()));
      },
      builder: (context, state) => ScreenFrame(child: SignUpScreen()),
    ),
    GoRoute(
      path: routeLectures,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: ScreenFrame(child: LectureList()));
      },
      builder: (context, state) => const ScreenFrame(child: LectureList()),
    ),
    GoRoute(
      path: routeContacts,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
            child: ScreenFrame(child: ContactsList()));
      },
      builder: (context, state) => const ScreenFrame(child: ContactsList()),
    ),
    GoRoute(
      path: routeWriteContact,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
            child: ScreenFrame(child: ContactWrite()));
      },
      builder: (context, state) => const ScreenFrame(child: ContactWrite()),
    ),
    GoRoute(
      path: routeLectureDetail,
      pageBuilder: (context, state) {
        return NoTransitionPage(
            child: ScreenFrame(
                child: LectureDetail(
          id: state.params['id']!,
        )));
      },
      builder: (context, state) => ScreenFrame(
        child: LectureDetail(
          id: state.params['id']!,
        ),
      ),
    ),
    GoRoute(
      path: routeContactDetail,
      pageBuilder: (context, state) {
        return NoTransitionPage(
            child: ScreenFrame(
                child: ContactDetail(
          id: state.params['id']!,
        )));
      },
      builder: (context, state) => ScreenFrame(
        child: ContactDetail(
          id: state.params['id']!,
        ),
      ),
    ),
  ],
);

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  setPathUrlStrategy(); // remove '#'
  timeago.setLocaleMessages('kr', KrCustomMessages());
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '${dotenv.env['NATIVE_APP_KEY']}',
    javaScriptAppKey: '${dotenv.env['JAVASCRIPT_APP_KEY']}',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'D.W.D',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
      ),
      // builder: (context, child) => ScreenFrame(child: child!),
      // home: const MyHomePage(
      //   title: 'D.W.D',
      // ),
    );
  }
}

// Navigation by NavigationRail
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     // final ButtonStyle style = TextButton.styleFrom(
//     //   foregroundColor: Theme.of(context).colorScheme.onPrimary,
//     // );
//     Widget page;
//     switch (_selectedIndex) {
//       case 0:
//         page = const LectureList();
//         break;
//       case 1:
//         page = const Placeholder();
//         break;
//       default:
//         throw UnimplementedError('No page for $_selectedIndex');
//     }
//     // IconData arrowIconData;
//     // arrowIconData =
//     //     _extended ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios;
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.accessibility_new_rounded),
//         actions: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               foregroundColor: Theme.of(context).colorScheme.onPrimary,
//             ),
//             onPressed: (() {}),
//             child: TextButton.icon(
//                 onPressed: (() {}),
//                 style: TextButton.styleFrom(foregroundColor: Colors.black),
//                 icon: const Icon(Icons.login),
//                 label: const Text('로그인')),
//           )
//         ],
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: const Text(
//           'D.W.D',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: LayoutBuilder(builder: (context, constraints) {
//         return Row(
//           children: [
//             SafeArea(
//               child: NavigationRail(
//                 extended: constraints.maxWidth >= 600,
//                 destinations: const [
//                   NavigationRailDestination(
//                     icon: Icon(Icons.computer),
//                     label: Text('인강'),
//                   ),
//                   NavigationRailDestination(
//                     icon: Icon(Icons.mail),
//                     label: Text('문의'),
//                   ),
//                 ],
//                 selectedIndex: _selectedIndex,
//                 onDestinationSelected: (value) =>
//                     setState(() => _selectedIndex = value),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 child: page,
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
