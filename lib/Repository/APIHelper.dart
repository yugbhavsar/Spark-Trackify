import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;


var baseURI = "https://hrms-api.taskgrids.com/api/" ;
var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vaHJtcy1hcGkudGFza2dyaWRzLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MzEzMTkyNTgsImV4cCI6MTczMzkxMTI1OCwibmJmIjoxNzMxMzE5MjU4LCJqdGkiOiI2blZNZG55NTNvMnhyekVTIiwic3ViIjoiNDM5IiwicHJ2IjoiZjkzMDdlYjVmMjljNzJhOTBkYmFhZWYwZTI2ZjAyNjJlZGU4NmY1NSJ9.7e4nS50zv8NGu2D44ho7Hs0lFWO9L4XG8jRIthUX-ok";

class API {

  API._internal();

  static final API _instance = API._internal();

  static API get Shared => _instance;


  Future<Map<String, dynamic>> get(String endPoint ) async {

    var url = Uri.http(baseURI+endPoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    }else{
      print("something went wrong");
      return {"message":"Something went wrong "};
    }
  }

  Future<Map<String, dynamic>> post(String endPoint, Map<String, dynamic> param) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    var url = Uri.parse(baseURI + endPoint);

    try {
      var response = await http.post(url, headers: header, body: convert.jsonEncode(param));

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        return {"message": "Something went wrong", "statusCode": response.statusCode};
      }
    } catch (error) {
      return {"message": "Exception occurred"};
    }
  }

}