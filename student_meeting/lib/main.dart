import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:student_meeting/model/profileModel.dart';
import 'package:student_meeting/model/reservation_model.dart';
import 'package:student_meeting/route/router.dart';
import 'package:student_meeting/view/screen/main_screen.dart';
import 'package:student_meeting/view/screen/profile_detail.dart';
import 'package:student_meeting/view/screen/schedule_screen.dart';
import 'package:student_meeting/viewmodel/mainViewModel.dart';
import 'package:student_meeting/viewmodel/reservationViewModel.dart';

import 'network/apiservice/api_service.dart';
import 'network/repository/repository_service.dart';
import 'network/repository/repository_service_impl.dart';
import 'network/result.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  final ApiServiceRepository _apiServiceRepository = ApiServiceRepositoryImpl();

  // Test getTeacherProfile
  final Result<List<ProfileModel>> resultProfile =
  await _apiServiceRepository.getTeacherProfile();
  // print(resultProfile);
  // Test getReserve
  final Result<List<ReservationModel>> resultReserve =
  await _apiServiceRepository.getReserve();
  // print(resultReserve);

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainViewModel()),
        ChangeNotifierProvider(create: (context) => ReservationViewModel()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router, // Ensure this is properly defined
      ),
    );
  }
}
class MainScreenWithBottomNavBar extends StatefulWidget {
  @override
  _MainScreenWithBottomNavBarState createState() => _MainScreenWithBottomNavBarState();
}

class _MainScreenWithBottomNavBarState extends State<MainScreenWithBottomNavBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    ScheduleScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '선생님 찾기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: '내 상담 일정',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
