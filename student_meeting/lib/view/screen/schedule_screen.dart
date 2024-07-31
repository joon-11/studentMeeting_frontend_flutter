import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';

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
    return ShowSchdule(
        schedule: viewModel.reservationList);
  }
}

class ShowSchdule extends StatefulWidget {
  final List<ReservationModel> schedule;

  const ShowSchdule({super.key, required this.schedule});

  @override
  State<ShowSchdule> createState() => _ShowSchduleState();
}

class _ShowSchduleState extends State<ShowSchdule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내일정'),
      ),
      // body: ListView.builder(itemBuilder: itemBuilder)
    );
  }
}
