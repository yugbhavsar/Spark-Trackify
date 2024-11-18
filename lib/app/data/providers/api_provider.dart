import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiProvider {
  static final ApiProvider _apiProvider = ApiProvider._();

  ApiProvider._();

  final Map<String, String> _headers = <String, String>{'Content-Type': 'application/json', 'Accept': 'application/json'};

  static ApiProvider get instance => _apiProvider;

  String unauthorizedError = 'Unauthorized Access';
  String permissionError = 'You do not have access to this resource';
  String noInternetFoundError = 'No Internet connection was found.';
  String requestTimeoutError = 'Request time out';
  String fileSizeError = 'File size exceeds.';

  Future<Map<String, dynamic>> postRequest({required String endPoint, Map<String, String>? body, String? token}) async {
    try {
      log("log: ${jsonEncode(body)}");
      final response = await http
          .post(Uri.parse(dotenv.get("BASE_URL", fallback: "") + endPoint),
              headers: {
                ..._headers,
                if ((token ?? "").isNotEmpty) ...{'Authorization': "Bearer ${token!}"}
              },
              body: jsonEncode(body.toString()))
          .timeout(const Duration(seconds: 35));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        throw permissionError;
      }

      throw response.statusCode == 401 ? unauthorizedError : jsonDecode(response.body)['message'];
    } on SocketException {
      throw noInternetFoundError;
    } on TimeoutException {
      throw requestTimeoutError;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> multipartPostRequest(
      {required String endPoint, Map<String, String>? body, String? token, required List<MultipartFile> files}) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(
          dotenv.get("BASE_URL", fallback: "") + endPoint,
        ),
      );
      if (body != null) {
        request.fields.addAll(body);
      }
      request.files.addAll(files);
      request.headers.addAll({
        ..._headers,
        if ((token ?? "").isNotEmpty) ...{'Authorization': "Bearer ${token!}"}
      });

      final response = await http.Response.fromStream(await request.send()).timeout(const Duration(seconds: 35));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw unauthorizedError;
      } else if (response.statusCode == 403) {
        throw permissionError;
      } else if (response.statusCode == 413) {
        throw fileSizeError;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } on SocketException {
      throw noInternetFoundError;
    } on TimeoutException {
      throw requestTimeoutError;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRequest({required String endPoint, String? token}) async {
    try {
      final response = await http.get(Uri.parse(dotenv.get("BASE_URL", fallback: "") + endPoint), headers: {
        ..._headers,
        if ((token ?? "").isNotEmpty) ...{'Authorization': "Bearer ${token!}"}
      }).timeout(const Duration(seconds: 35));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 403) {
        throw permissionError;
      }
      throw response.statusCode == 401 ? unauthorizedError : jsonDecode(response.body)['message'];
    } on SocketException {
      throw noInternetFoundError;
    } on TimeoutException {
      throw requestTimeoutError;
    } catch (e) {
      rethrow;
    }
  }
}
