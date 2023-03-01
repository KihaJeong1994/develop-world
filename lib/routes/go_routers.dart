// GoRouter configuration
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
import 'package:go_router/go_router.dart';

final router = GoRouter(
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
