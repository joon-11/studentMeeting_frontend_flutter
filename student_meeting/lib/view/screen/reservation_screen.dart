import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_meeting/model/reservation_model.dart';
import 'package:student_meeting/viewmodel/reservationViewModel.dart';

import '../../viewmodel/mainViewModel.dart';


class ReservationScreen extends StatefulWidget {
  final dynamic profile;

  const ReservationScreen({super.key, required this.profile});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ReservationViewModel>(context);
    print(viewModel.reservationList);
    return ReservationListScreen(profile: widget.profile, schedule: viewModel.reservationList);
  }
}



class ReservationListScreen extends StatefulWidget {
  final dynamic profile;
  final List<ReservationModel> schedule;

  const ReservationListScreen({super.key, required this.profile, required this.schedule});

  @override
  State<ReservationListScreen> createState() => _ReservationListScreen();
}



class _ReservationListScreen extends State<ReservationListScreen> {
  String _d1 = '';
  String _t1 = '';

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_getMonthName(date.month)}, '
        '${date.year}';
  }

  String formatTime(DateTime time) {
    final hours = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '${hours.toString().padLeft(2, '0')}:$minutes $period';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("${widget.schedule[0].r_no}"),
              DateTimePicker(
                initialSelectedDate: dt,
                startDate: dt,
                endDate: dt.add(const Duration(days: 60)),
                startTime: DateTime(dt.year, dt.month, dt.day, 6),
                endTime: DateTime(dt.year, dt.month, dt.day, 18),
                timeInterval: const Duration(minutes: 15),
                datePickerTitle: 'Pick your preferred date',
                timePickerTitle: 'Pick your preferred time',
                timeOutOfRangeError: '참여 가능 시간이 없습니다.',
                is24h: false,
                onDateChanged: (date) {
                  setState(() {
                    _d1 = formatDate(date);
                  });
                },
                onTimeChanged: (time) {
                  setState(() {
                    _t1 = formatTime(time);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
