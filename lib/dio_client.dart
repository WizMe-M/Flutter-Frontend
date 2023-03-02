import 'dart:io';

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
  final _ip = Platform.isWindows ? "localhost" : "192.168.1.118";
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

    return ModelResponse.fromJson(response.data);
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

    return ModelResponse.fromJson(response.data);
  }

  Future<ModelResponse?> updateProfile(
      {required String token,
      required String email,
      required String username}) async {
    Response? response;

    var inputted = User(email: email, userName: username);

    try {
      response = await _dio.post('$_baseUrl/user',
          data: inputted.toJson(),
          options: Options(headers: {authHeader: 'Bearer $token'}));
    } on DioError catch (e) {
      return e.response?.data != null
          ? ModelResponse.fromJson(e.response!.data)
          : null;
    }

    return ModelResponse.fromJson(response.data);
  }

  Future<ModelResponse?> getProfile({required String token}) async {
    Response? response;

    try {
      response = await _dio.get('$_baseUrl/user',
          options: Options(headers: {authHeader: 'Bearer $token'}));
    } on DioError catch (e) {
      return e.response?.data != null
          ? ModelResponse.fromJson(e.response!.data)
          : null;
    }

    return ModelResponse.fromJson(response.data);
  }
}
