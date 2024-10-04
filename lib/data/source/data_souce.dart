import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class Network {
  const Network();
  Future<Object?> get(
      {required String api, Map<String, String>? query, String? id});
  Future<Object?> post(
      {required String api, required Map<String, Object?> body});
  Future<Object?> put(
      {required String api, Map<String, Object?>? body, required String id});
  Future<Object?> delete({required String api, required String id});
}

class DioService extends Network {
  final Dio dio;
  const DioService({required this.dio});

  void configuration(String baseUrl) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
    );
  }

  @override
  Future<Object?> get(
      {required String api, Map<String, String>? query, String? id}) async {
    Response response = await dio.get(api);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return null;
    }
  }

  @override
  Future<Object?> post(
      {required String api, required Map<String, Object?> body}) async {
    Response response = await dio.post(api, data: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return null;
    }
  }

  @override
  Future<Object?> put(
      {required String api,
      Map<String, Object?>? body,
      required String id}) async {
    Response response = await dio.put("$api/$id", data: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return null;
    }
  }

  @override
  Future<Object?> delete({required String api, required String id}) async {
    Response response = await dio.delete("$api/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      return null;
    }
  }
}

@immutable
sealed class Api {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";
  static const String apiPost = "/posts";
}
