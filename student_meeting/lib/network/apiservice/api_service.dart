import 'dart:convert';
import '../result.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static String apiUrl = "http://10.0.2.2:3000";

  Future<Result<Response>> getTeacherProfile() async {
    final url = Uri.parse('$apiUrl/api/t_profiles');
    try {
      final response = await http.get(url);
      return Result.success(response);
    } catch (err) {
      print(err);
      return Result.error('service api error');
    }
  }

  Future<Result<Response>> getReserve() async {
    final url = Uri.parse('$apiUrl/api/reserveConfirm');
    try {
      final response = await http.get(url);
      print(response);
      return Result.success(response);
    } catch (err) {
      print(err);
      return Result.error('service api error');
    }
  }

  Future<Result<Response>> postReserve(String time, int person, String lib) async {
    final url = Uri.parse('$apiUrl/api/reserve');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"time": time, "person": person, "lib": lib});

    try {
      final response = await http.post(url, headers: headers, body: body);
      return Result.success(response);
    } catch (err) {
      print(err);
      return Result.error('service api error');
    }
  }

  Future<Result<Response>> postCancel(String time, int person) async {
    final url = Uri.parse('$apiUrl/api/cancel');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"time": time, "person": person});

    try {
      final response = await http.post(url, headers: headers, body: body);
      return Result.success(response);
    } catch (err) {
      print(err);
      return Result.error('service api error');
    }
  }
}
