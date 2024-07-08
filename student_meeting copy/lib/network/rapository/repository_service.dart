import '../result.dart';

abstract class ApiServiceRepository {
  Future<Result<String>> getTeacherProfile();

}