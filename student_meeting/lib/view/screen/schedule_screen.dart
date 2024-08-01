import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';
import 'package:intl/intl.dart';

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
    final viewModel = Provider.of<ReservationViewModel>(context);
    print(viewModel.reservationList);
    return ShowSchedule(
      schedule: viewModel.reservationList,
    );
  }
}

class ShowSchedule extends StatefulWidget {
  final List<ReservationModel> schedule;

  const ShowSchedule({super.key, required this.schedule});

  @override
  State<ShowSchedule> createState() => _ShowScheduleState();
}

class _ShowScheduleState extends State<ShowSchedule> {
  void showPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("수업 취소하기"))
          ],
        );
      },
    );
  }

  selectPhoto(lib) {
    List photo = [
      'lib/images/루피.webp',
      'lib/images/조로.webp',
      'lib/images/나미.webp',
      'lib/images/우솝.webp',
      'lib/images/상디.jpeg',
      'lib/images/쵸파.webp'
    ];

    if (lib == "국어") {
      return (photo[0]);
    } else if (lib == "검술") {
      return (photo[1]);
    } else if (lib == "항해술") {
      return (photo[2]);
    } else if (lib == "사격") {
      return (photo[3]);
    } else if (lib == "요리") {
      return (photo[4]);
    } else if (lib == "의학") {
      return (photo);
    } else {
      return (photo[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 일정', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: widget.schedule.length,
        itemBuilder: (context, index) {
          final ReservationModel profile = widget.schedule[index];
          final DateTime dateTime = DateTime.parse(profile.time!);
          final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
          final String formattedStartTime = formatter.format(dateTime);
          final String formattedEndTime =
              formatter.format(dateTime.add(Duration(hours: 1)));

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: CupertinoColors.inactiveGray,
                backgroundImage: AssetImage(selectPhoto(profile.lib)),
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
                    '시간: $formattedStartTime - $formattedEndTime');
              },
            ),
          );
        },
      ),
    );
  }
}
