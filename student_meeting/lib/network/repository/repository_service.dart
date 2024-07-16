import 'package:student_meeting/model/profileModel.dart';

import '../result.dart';

abstract class ApiServiceRepository {
  Future<Result<List<ProfileModel>>> getTeacherProfile();
  Future<Result<List<ProfileModel>>> getReserve();
  Future<Result<String>> postReserve(String time, int person);
  Future<Result<String>> postCancel(String time, int person);
}
