import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_meeting/model/reservation_model.dart';
import 'package:student_meeting/viewmodel/reservationViewModel.dart';
import 'package:intl/date_symbol_data_local.dart';

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
    return ReservationListScreen(
        profile: widget.profile, schedule: viewModel.reservationList);
  }
}

class ReservationListScreen extends StatefulWidget {
  final dynamic profile;
  final List<ReservationModel> schedule;

  const ReservationListScreen(
      {super.key, required this.profile, required this.schedule});

  @override
  State<ReservationListScreen> createState() => _ReservationListScreen();
}

class _ReservationListScreen extends State<ReservationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BookingCalendarDemoApp(
      schedule: widget.schedule,
      profile: widget.profile,
    ));
  }
}

class BookingCalendarDemoApp extends StatefulWidget {
  final List<ReservationModel> schedule;
  final dynamic profile;

  const BookingCalendarDemoApp(
      {Key? key, required this.schedule, required this.profile})
      : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
  }

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 60,
      bookingEnd: DateTime(now.year, now.month, now.day, 23, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );
  }

  Stream<List<DateTimeRange>> getBookingStreamMock(
      {required DateTime end, required DateTime start}) async* {
    List<DateTimeRange> bookedTimes = widget.schedule
        .where((item) => item.lib == widget.profile.t_lib)
        .map((item) {
      DateTime startTime = DateTime.parse(item.time!).toLocal();
      DateTime endTime = startTime.add(const Duration(hours: 1));
      return DateTimeRange(start: startTime, end: endTime);
    }).toList();

    yield bookedTimes;
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    List<DateTimeRange> schedule = streamResult as List<DateTimeRange>;
    print(schedule);
    return schedule;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('상담 예약'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: BookingCalendar(
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            hideBreakTime: false,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const CircularProgressIndicator(),
            locale: 'ko',
            startingDayOfWeek: StartingDayOfWeek.sunday,
            wholeDayIsBookedWidget:
                const Text('Sorry, for this day everything is booked'),
          ),
        ),
      ),
    );
  }
}
