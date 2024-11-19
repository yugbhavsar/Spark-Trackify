import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert ;


var baseURI = "https://hrms-api.taskgrids.com/api/" ;
var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vaHJtcy1hcGkudGFza2dyaWRzLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MzA4NjUwNjgsImV4cCI6MTczMzQ1NzA2OCwibmJmIjoxNzMwODY1MDY4LCJqdGkiOiJXRnk0d3FQWFBYek5QelJHIiwic3ViIjoiNDM5IiwicHJ2IjoiZjkzMDdlYjVmMjljNzJhOTBkYmFhZWYwZTI2ZjAyNjJlZGU4NmY1NSJ9.goupjzot2zX05OxiEQlNJLgBGrPoIdYINjjdjOltTtc";

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


class FireDb {

  FireDb._internal();

  static final FireDb _instance = FireDb._internal();

  static FireDb get Shared => _instance;

  final rtFireDb = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://espark-trackify-default-rtdb.asia-southeast1.firebasedatabase.app/');


  Future setFireData() async {

    DatabaseReference ref = rtFireDb.ref("UserToken");

    await ref.set({
      "name": "John",
      "age": 20,
      "token": token
    });
  }

  Future getToken(Function(bool) completion) async {

    DatabaseReference ref = rtFireDb.ref("UserToken");

    final response = await ref.get();

    if (response.exists){
      print(response.value);
      completion(true);
    }else{
      completion(false);
      print('No data available.');
    }
  }

  Future setDeviceData() async {

    DatabaseReference ref = rtFireDb.ref("DeviceList");

    await ref.set({
      "data":[
        {
          "deviceName": "iPhone 11",
          "deviceUrl": "devieImage/",
          "deviceID": "123456",
          "assignTo": "Yug Bhavsar",
          "employeeId": "22Dev035",
          "assignFor": "Development",
          "notes": "",
        },
        {
          "deviceName": "iPad 3rdGen",
          "deviceUrl": "devieImage/",
          "deviceID": "123456",
          "assignTo": "Yug Bhavsar",
          "employeeId": "22Dev035",
          "assignFor": "Development",
          "notes": "",
        },
        {
          "deviceName": "iPad 10thGen",
          "deviceUrl": "devieImage/",
          "deviceID": "123456",
          "assignTo": "Yug Bhavsar",
          "employeeId": "22Dev035",
          "assignFor": "Development",
          "notes": "",
        },
      ]
    });
  }


}