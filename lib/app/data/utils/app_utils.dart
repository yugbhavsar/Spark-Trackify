import 'dart:developer';

import 'package:intl/intl.dart';

String getDeviceImage({required String modelName}) {
  log("log: ${modelName}");
  if (modelName.isEmpty) {
    // modelName = "iphone12";
    modelName = "phone";
  }
  return "assets/phones/${modelName.toLowerCase().replaceAll(" ", "")}.png";
}

String getFormattedDateTime(String dateTimeStr) {
  DateTime dateTime = DateTime.parse(dateTimeStr);

  String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(dateTime);

  return formattedDate;
}
