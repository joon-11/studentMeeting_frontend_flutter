import 'dart:convert';
import 'package:http/http.dart';
import 'package:student_meeting/model/profileModel.dart';
import 'package:student_meeting/network/repository/repository_service.dart';
import 'package:student_meeting/network/result.dart';
import '../apiservice/api_service.dart';

class ApiServiceRepositoryImpl implements ApiServiceRepository {
  final ApiService _api = ApiService();

  @override
  Future<Result<List<ProfileModel>>> getTeacherProfile() async {
    final Result<Response> result = await _api.getTeacherProfile();

    if (result is Success) {
      final response = (result as Success).data;
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        print(jsonData);
        List<ProfileModel> profiles = jsonData.map((item) => ProfileModel.fromJson(item)).toList();
        return Result.success(profiles);
      } else {
        return Result.error('Error: ${response.statusCode}');
      }
    } else {
      return Result.error((result as Error).message);
    }
  }

  @override
  Future<Result<List<ProfileModel>>> getReserve() async {
    final Result<Response> result = await _api.getReserve();

    if (result is Success) {
      final response = (result as Success).data;
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        List<ProfileModel> profiles = jsonData.map((item) => ProfileModel.fromJson(item)).toList();
        return Result.success(profiles);
      } else {
        return Result.error('Error: ${response.statusCode}');
      }
    } else {
      return Result.error((result as Error).message);
    }
  }

  @override
  Future<Result<String>> postReserve(String time, int person) async {
    final Result<Response> result = await _api.postReserve(time, person);

    if (result is Success) {
      final response = (result as Success).data;
      if (response.statusCode == 200) {
        return Result.success(response.body);
      } else {
        return Result.error('Error: ${response.statusCode}');
      }
    } else {
      return Result.error((result as Error).message);
    }
  }

  @override
  Future<Result<String>> postCancel(String time, int person) async {
    final Result<Response> result = await _api.postCancel(time, person);

    if (result is Success) {
      final response = (result as Success).data;
      if (response.statusCode == 200) {
        return Result.success(response.body);
      } else {
        return Result.error('Error: ${response.statusCode}');
      }
    } else {
      return Result.error((result as Error).message);
    }
  }
}
