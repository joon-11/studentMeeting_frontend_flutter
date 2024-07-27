import 'package:flutter/cupertino.dart';
import 'package:student_meeting/model/reservation_model.dart';

import '../model/profileModel.dart';
import '../network/repository/repository_service.dart';
import '../network/repository/repository_service_impl.dart';
import '../network/result.dart';

class ReservationViewModel with ChangeNotifier {
  final ApiServiceRepository _apiServiceRepository =
  ApiServiceRepositoryImpl();
  List<ReservationModel> _ReservationCheck = [];
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
    final Result<List<ProfileModel>> result
    = await _apiServiceRepository.getReserve();
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