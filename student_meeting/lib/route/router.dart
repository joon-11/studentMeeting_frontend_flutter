import 'package:go_router/go_router.dart';
import 'package:student_meeting/main.dart';
import 'package:student_meeting/view/screen/main_screen.dart';
import 'package:student_meeting/view/screen/profile_detail.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MainScreenWithBottomNavBar(),

    ),

    // GoRoute(
    //   path: '/profileDetail',
    //   builder: (context, state) =>
    //       ProfileDetail(1),
    // ),

    //
    // GoRoute(
    //   path: '/classB',
    //   builder: (context, state) => ClassB(),
    // ),
  ],
);

// inal router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) {
//         return SchoolPage();
//       },
//     ),
//     GoRoute(
//       path: '/student/:id',
//       builder: (context, state) {
//         return StudentPage(state.pathParameters['id']);
//       },
//     ),
//   ],
// );
