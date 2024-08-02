import 'package:student_meeting/model/profileModel.dart';
import 'package:student_meeting/model/reservation_model.dart';

import '../result.dart';

abstract class ApiServiceRepository {
  Future<Result<List<ProfileModel>>> getTeacherProfile();
  Future<Result<List<ReservationModel>>> getReserve();
  Future<Result<String>> postReserve(String time, int person, String lib);
  Future<Result<String>> postCancel(String time, int person);
}
