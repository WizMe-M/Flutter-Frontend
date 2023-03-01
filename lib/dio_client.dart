import 'package:dio/dio.dart';
import 'package:flutter_frontend/model/model_response.dart';
import 'package:flutter_frontend/model/user.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 3500),
      receiveTimeout: const Duration(minutes: 10),
      sendTimeout: const Duration(milliseconds: 3500)));

  static const String authHeader = 'Authorization';

  final _protocol = "http";
  final _ip = "localhost";
  final _port = 5781;

  String get _baseUrl => '$_protocol://$_ip:$_port';

  Future<ModelResponse?> authenticate(
      {required String username, required String password}) async {
    Response? response;
    var inputted = User(userName: username, password: password);

    try {
      response = await _dio.post('$_baseUrl/token',
          data: inputted.toJson(),
          options: Options(receiveDataWhenStatusError: true));
    } on DioError catch (e) {
      return e.response?.data != null
          ? ModelResponse.fromJson(e.response!.data)
          : null;
    }

    var modelResponse = ModelResponse.fromJson(response.data);
    var user = User.fromJson(modelResponse.data);

    // 'Authorization' Header with Bearer JWT-token for next requests in this session
    _dio.options.headers[authHeader] = 'Bearer ${user.accessToken}';

    return modelResponse;
  }

  Future<ModelResponse?> register(
      {required String email,
      required String username,
      required String password}) async {
    Response? response;
    var inputted = User(email: email, userName: username, password: password);

    try {
      response = await _dio.put('$_baseUrl/token',
          data: inputted.toJson(),
          options: Options(receiveDataWhenStatusError: true));
    } on DioError catch (e) {
      return e.response?.data != null
          ? ModelResponse.fromJson(e.response!.data)
          : null;
    }

    var modelResponse = ModelResponse.fromJson(response.data);
    return modelResponse;
  }
}
