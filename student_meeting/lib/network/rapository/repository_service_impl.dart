import 'dart:convert';

import 'package:http/http.dart';
import 'package:student_meeting/network/rapository/repository_service.dart';
import 'package:student_meeting/network/result.dart';

import '../apiservice/api_service.dart';

class ApiServiceRepositoryImpl implements ApiServiceRepository{
  @override
  Future<Result<String>> getTeacherProfile() async{
    final _api = ApiService();
    final Result<Response> result = await _api.getTeacherProfile();

    if (result is Success) {
      final response = (result as Success).data;
      if (response.statusCode == 200) {
        return Result.success('test');
      } else {
        return Result.error('2');   // No account
      }
    } else {
      return Result.error((result as Error).message);
    }
  }

}