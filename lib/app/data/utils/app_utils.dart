import 'dart:developer';

class AppUtils {
  static String getDeviceImage({required String modelName}) {
    log("log: ${modelName}");
    if (modelName.isEmpty) {
      // modelName = "iphone12";
      modelName = "ipadair3";
    }
    return "assets/phones/${modelName.toLowerCase().replaceAll(" ", "")}.png";
  }
}
