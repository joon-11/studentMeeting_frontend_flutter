import 'package:flutter/cupertino.dart';
import 'package:student_meeting/model/reservation_model.dart';

import '../model/profileModel.dart';
import '../network/repository/repository_service.dart';
import '../network/repository/repository_service_impl.dart';
import '../network/result.dart';

class ReservationViewModel with ChangeNotifier {
  final ApiServiceRepository _apiServiceRepository = ApiServiceRepositoryImpl();
  List<ReservationModel> _ReservationCheck = [];
  List<String> _ReservationInsert = [];
  bool _fetchCompleted = false;
  String _errorCode = "";
  bool _disposed = false;

  List<ReservationModel> get reservationList => _ReservationCheck;

  ReservationViewModel() {
    _fetch();
  }

  Future<void> _fetch() async {
    _fetchCompleted = false;
    _notifyListeners();
    await _loadReservation();
    _fetchCompleted = true;
    _notifyListeners();
  }

  Future<void> _loadReservation() async {
    final Result<List<ReservationModel>> result =
        await _apiServiceRepository.getReserve();
    if (result is Success) {
      _ReservationCheck = (result as Success).data;
      print(_ReservationCheck);
    } else {
      _errorCode = (result as Error).message;
      if (_errorCode == '3') {
        print('No data or Failed to fetch data');
      } else {
        print(_errorCode);
      }
      _ReservationCheck = [];
    }
  }

  Future<void> insertReservation(String date, int person, String lib) async {
    final Result<String> result =
        await _apiServiceRepository.postReserve(date, person, lib);
    if (result is Success) {
      _ReservationCheck.add(ReservationModel(
          r_no: 100, time: date, confirm: 'y', reserve_p: 1, lib: lib));
      _notifyListeners();
    } else {
      _errorCode = (result as Error).message;
      if (_errorCode == '3') {
        print('No data or Failed to fetch data');
      } else {
        print(_errorCode);
      }
      _ReservationCheck = [];
    }
  }

  Future<void> deleteReservation(String date, int person) async {
    final Result<String> result =
        await _apiServiceRepository.postCancel(date, person);
    if (result is Success) {
      late ReservationModel reserve;
      for (var reservation in _ReservationCheck) {
        String datetimeWithoutSeconds = reservation.time!.substring(0, 16);
        String day = date.replaceAll(RegExp(r'[-: ]'), '');
        String reservation_day = datetimeWithoutSeconds.replaceAll(RegExp(r'[-: ]'), '');
        if (day == reservation_day) {
         reserve = reservation;
        }
      }
      _ReservationCheck.remove(reserve);
      _notifyListeners();

    } else {
      _errorCode = (result as Error).message;
      if (_errorCode == '3') {
        print('No data or Failed to fetch data');
      } else {
        print(_errorCode);
      }

    }
  }

  void _notifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
