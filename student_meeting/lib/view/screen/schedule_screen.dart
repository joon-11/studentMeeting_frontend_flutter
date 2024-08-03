import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:student_meeting/viewmodel/mainViewModel.dart';

import '../../model/reservation_model.dart';
import '../../viewmodel/reservationViewModel.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModelMain = Provider.of<MainViewModel>(context);
    final viewModel = Provider.of<ReservationViewModel>(context);
    print(viewModel.reservationList);
    return ShowSchedule(
      schedule: viewModel.reservationList,
    );
  }
}

class ShowSchedule extends StatefulWidget {
  final List<ReservationModel> schedule;
  late MainViewModel viewModelMain;

  ShowSchedule({super.key, required this.schedule});

  @override
  State<ShowSchedule> createState() => _ShowScheduleState();
}

class _ShowScheduleState extends State<ShowSchedule> {
  void showPopup(BuildContext context, String title, String message, String time) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                widget.viewModelMain.deleteReservation(time,1);
              },
              child: const Text("수업 취소하기"),
            )
          ],
        );
      },
    );
  }

  String selectPhoto(String lib) {
    List<String> photo = [
      'lib/images/루피.webp',
      'lib/images/조로.webp',
      'lib/images/나미.webp',
      'lib/images/우솝.webp',
      'lib/images/상디.jpeg',
      'lib/images/쵸파.webp'
    ];

    switch (lib) {
      case "국어":
        return photo[0];
      case "검술":
        return photo[1];
      case "항해술":
        return photo[2];
      case "사격":
        return photo[3];
      case "요리":
        return photo[4];
      case "의학":
        return photo[5];
      default:
        return photo[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    List<ReservationModel> futureSchedule = widget.schedule
        .where((reservation) => DateTime.parse(reservation.time!).toLocal().isAfter(now))
        .toList();

    // Sort the futureSchedule list by the reservation time
    futureSchedule.sort((a, b) {
      DateTime aTime = DateTime.parse(a.time!).toLocal();
      DateTime bTime = DateTime.parse(b.time!).toLocal();
      return aTime.compareTo(bTime);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 일정', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: futureSchedule.length,
        itemBuilder: (context, index) {
          final ReservationModel profile = futureSchedule[index];
          final DateTime dateTime = DateTime.parse(profile.time!).toLocal();
          final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
          final String formattedStartTime = formatter.format(dateTime);
          final String formattedEndTime =
          formatter.format(dateTime.add(const Duration(hours: 1)));

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: CupertinoColors.inactiveGray,
                backgroundImage: AssetImage(selectPhoto(profile.lib!)),
              ),
              title: Text(
                '${profile.lib} 수업 시간',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '$formattedStartTime - $formattedEndTime',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              onTap: () {
                showPopup(context, '${profile.lib} 수업 정보',
                    '시간: $formattedStartTime - $formattedEndTime', formattedStartTime);
              },
            ),
          );
        },
      ),
    );
  }
}
