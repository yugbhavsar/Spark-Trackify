import 'package:spark_trackify/app/data/providers/api_endpoints.dart';
import 'package:spark_trackify/app/data/providers/api_provider.dart';
import 'package:spark_trackify/app/data/utils/app_preference.dart';
import 'package:spark_trackify/app/features/HomeScreen/models/employee_model.dart';

class AssignDetailsRepository {
  Future<List<EmployeeModel>> fetchEmployees() async {
    Map<String, dynamic> json = await ApiProvider.instance.postRequest(
      endPoint: ApiEndpoints.loginEndpoint,
      token: AppPreference.instance.getToken(),
    );

    List list = json["data"];

    return list.map((e) => EmployeeModel.fromMap(e)).toList();
  }
}
