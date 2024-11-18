import 'dart:developer';

import 'package:spark_trackify/app/data/providers/api_endpoints.dart';
import 'package:spark_trackify/app/data/providers/api_provider.dart';

class LoginRepository {
  Future<String> loginRequest({required String email, required String password}) async {
    Map<String, dynamic> json =
        await ApiProvider.instance.postRequest(endPoint: ApiEndpoints.loginEndpoint, body: {"email": email, "password": password});

    Map<String, dynamic> token = json;
    log("log: ${token}");

    return "";
  }
}
