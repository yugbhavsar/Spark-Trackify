import 'package:spark_trackify/app/data/providers/api_provider.dart';
import 'package:spark_trackify/app/data/services/firebase_service.dart';
import 'package:spark_trackify/app/features/home_screen/models/employee_model.dart';

class HomeRepository {
  Future<List<EmployeeModel>> getEmployeeData() async {
    String token = await FirebaseService.instance.getToken();
    final json = await ApiProvider.instance.postRequest(endPoint: "attendance/hotline", body: {"status": "online"}, token: token);
    List list = json["data"];
    return list.map((e) => EmployeeModel.fromMap(e)).toList();
  }
}
