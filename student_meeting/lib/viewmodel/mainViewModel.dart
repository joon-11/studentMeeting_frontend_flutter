import 'package:flutter/cupertino.dart';
import 'package:student_meeting/model/reservation_model.dart';

import '../model/profileModel.dart';
import '../network/repository/repository_service.dart';
import '../network/repository/repository_service_impl.dart';
import '../network/result.dart';

class MainViewModel with ChangeNotifier {
  final ApiServiceRepository _apiServiceRepository =
  ApiServiceRepositoryImpl();
  List<ProfileModel> _teacherProfileList = [];
  bool _fetchCompleted = false;
  String _errorCode = "";
  bool _disposed = false;
  List<ProfileModel> get profileList => _teacherProfileList;

  MainViewModel() {
    _fetch();
  }

  Future<void> _fetch() async {
    _fetchCompleted = false;
    _notifyListeners();
    await _loadProfile();
    _fetchCompleted = true;
    _notifyListeners();
  }

  Future<void> _loadProfile() async {
    final Result<List<ProfileModel>> result
    = await _apiServiceRepository.getTeacherProfile();
    if (result is Success) {
      _teacherProfileList = (result as Success).data;
      print(_teacherProfileList);
    } else {
      _errorCode = (result as Error).message;
      if (_errorCode == '3') {
        print('No data or Failed to fetch data');
      } else {
        print(_errorCode);
      }
      _teacherProfileList = [];
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