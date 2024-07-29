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
        body: BookingCalendarDemoApp(schedule: widget.schedule,)
    );
  }
}

class BookingCalendarDemoApp extends StatefulWidget {
  final List<ReservationModel> schedule;

  const BookingCalendarDemoApp({Key? key, required this.schedule}) : super(key: key);

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
    List<DateTimeRange> bookedTimes = widget.schedule.map((item) {
      DateTime startTime = DateTime.parse(item.time!).toLocal();
      DateTime endTime = startTime.add(Duration(hours: 1));
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

  // List<DateTimeRange> converted = [];
  //
  // List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
  //   ///here you can parse the streamresult and convert to [List<DateTimeRange>]
  //   ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
  //   ///disabledDays will properly work with real data
  //   DateTime first = now;
  //   DateTime tomorrow = now.add(const Duration(days: 1));
  //   DateTime second = now.add(const Duration(minutes: 55));
  //   DateTime third = now.subtract(const Duration(minutes: 240));
  //   DateTime fourth = now.subtract(const Duration(minutes: 500));
  //   converted.add(
  //       DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
  //   converted.add(DateTimeRange(
  //       start: second, end: second.add(const Duration(minutes: 23))));
  //   converted.add(DateTimeRange(
  //       start: third, end: third.add(const Duration(minutes: 15))));
  //   converted.add(DateTimeRange(
  //       start: fourth, end: fourth.add(const Duration(minutes: 50))));
  //
  //   //book whole day example
  //   converted.add(DateTimeRange(
  //       start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
  //       end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
  //
  //   return converted;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Calendar Demo'),
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
            startingDayOfWeek: StartingDayOfWeek.tuesday,
            wholeDayIsBookedWidget:
            const Text('Sorry, for this day everything is booked'),
          ),
        ),
      ),
    );
  }
}
