import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:student_meeting/model/profileModel.dart';
import 'package:student_meeting/view/screen/main_screen.dart';
import 'package:student_meeting/view/screen/profile_detail.dart';
import 'package:student_meeting/viewmodel/mainViewModel.dart';

import 'network/apiservice/api_service.dart';
import 'network/repository/repository_service.dart';
import 'network/repository/repository_service_impl.dart';
import 'network/result.dart';

// final GoRouter _router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return const MainScreen();
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           path: 'profileDetail',
//           builder: (BuildContext context, GoRouterState state) {
//             return const ProfileDetail();
//           },
//         ),
//       ],
//     ),
//   ],
// );


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  final ApiServiceRepository _apiServiceRepository = ApiServiceRepositoryImpl();

  // Test getTeacherProfile
  final Result<List<ProfileModel>> resultProfile =
      await _apiServiceRepository.getTeacherProfile();
  print(resultProfile);
  // Test getReserve
  final Result<List<ProfileModel>> resultReserve =
      await _apiServiceRepository.getReserve();

  // // Test postReserve
  // final Result<String> resultPostReserve = await _apiServiceRepository.postReserve("2024-01-01 12:00:01", 2);
  // print(resultPostReserve);
  //
  // // Test postCancel
  // final Result<String> resultPostCancel = await _apiServiceRepository.postCancel("2024-01-01 12:00:01", 3);
  // print(resultPostCancel);
}



class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MainViewModel(),
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
