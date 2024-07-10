import '../result.dart';

abstract class ApiServiceRepository {
  Future<Result<String>> getTeacherProfile();
  Future<Result<String>> getReserve();
  Future<Result<String>> postReserve(String time, int person);
  Future<Result<String>> postCancel(String time, int person);
}
