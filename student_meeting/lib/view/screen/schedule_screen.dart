import 'package:flutter/material.dart';
import 'package:time_scheduler_table/time_scheduler_table.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<EventModel> eventList = [
    EventModel(
      title: "Math",
      columnIndex: 0, // columnIndex is columnTitle's index (Monday : 0 or Day 1 : 0)
      rowIndex: 2, // rowIndex is rowTitle's index (08:00 : 0 or Time 1 : 0)
      color: Colors.orange,
    ),
    EventModel(
      title: "History",
      columnIndex: 1,
      rowIndex: 5,
      color: Colors.pink,
    ),
    EventModel(
      title: "Guitar & Piano Course",
      columnIndex: 4,
      rowIndex: 8,
      color: Colors.green,
    ),
    EventModel(
      title: "Meeting",
      columnIndex: 3,
      rowIndex: 1,
      color: Colors.deepPurple,
    ),
    EventModel(
      title: "Guitar and Piano Course",
      columnIndex: 2,
      rowIndex: 9,
      color: Colors.blue,
    )
  ];
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TimeSchedulerTable(
          cellHeight: 64,
          cellWidth: 72,
          columnTitles: const [ // You can assign any value to columnTitles. For Example : ['Column 1','Column 2','Column 3', ...]
            "월",
            "화",
            "수",
            "목",
            "금",
            "토",
            "일"
          ],
          currentColumnTitleIndex: DateTime.now().weekday - 1,
          rowTitles: const [ // You can assign any value to rowTitles. For Example : ['Row 1','Row 2','Row 3', ...]
            '08:00 - 09:00',
            '09:00 - 10:00',
            '10:00 - 11:00',
            '11:00 - 12:00',
            '12:00 - 13:00',
            '13:00 - 14:00',
            '14:00 - 15:00',
            '15:00 - 16:00',
            '16:00 - 17:00',
            '17:00 - 18:00',
            '18:00 - 19:00',
            '19:00 - 20:00',
            '20:00 - 21:00',
          ],
          title: "이번주 상담 시간표",
          titleStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          eventTitleStyle: const TextStyle(color: Colors.white, fontSize: 8),
          isBack: false, // back button
          eventList: eventList,
          eventAlert: EventAlert(
            alertTextController: textController,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            addAlertTitle: "Add Event",
            editAlertTitle: "Edit",
            addButtonTitle: "ADD",
            deleteButtonTitle: "DELETE",
            updateButtonTitle: "UPDATE",
            hintText: "Event Name",
            textFieldEmptyValidateMessage: "Cannot be empty!",
            addOnPressed: (event) { // when an event added to your list
              // Your code after event added.
            },
            updateOnPressed: (event) { // when an event updated from your list
              // Your code after event updated.
            },
            deleteOnPressed: (event) { // when an event deleted from your list
              // Your code after event deleted.
            },
          ),
        ),
      ),
    );
  }
}
