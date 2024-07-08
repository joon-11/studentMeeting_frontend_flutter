import '../result.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiService{
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
      return Result.success(response);
    } catch (err) {
      return Result.error('service api error');
    }
  }
}

