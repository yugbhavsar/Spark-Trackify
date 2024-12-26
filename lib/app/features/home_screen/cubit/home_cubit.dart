import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/features/home_screen/models/device_info_model.dart';
import 'package:spark_trackify/app/features/home_screen/models/employee_model.dart';
import 'package:spark_trackify/app/features/home_screen/repository/home_repository.dart';

import '../../../core/enums/app_enum.dart';
import '../../../data/services/device_info_service.dart';
import '../../../data/services/firebase_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeState.initial());

  void tabBarClick(int index) {
    HomeState homeState = state.copy();
    homeState.selectedTab = index;
    emit(homeState);
  }

  void fetchDeviceAndEmployeeData() async {
    HomeState homeState = state.copy();
    homeState.isLoading = true;
    emit(homeState);
    homeState = state.copy();

    List<DeviceDataModel> deviceDataList = await FirebaseService.instance.getDeviceList();
    List<EmployeeModel> employeeData = await homeRepository.getEmployeeData();
    homeState.employeeDataList = employeeData;
    homeState.filteredEmployeeList = employeeData;
    homeState.deviceDataList = deviceDataList;

    homeState.isLoading = false;
    emit(homeState);
  }

  void filterEmployees({required String query}) {
    HomeState homeState = state.copy();
    List<EmployeeModel> employeeList = homeState.employeeDataList ?? [];

    if (query.trim().isEmpty) {
      homeState.filteredEmployeeList = employeeList;
    } else {
      homeState.filteredEmployeeList = employeeList
          .where((element) =>
              (element.firstname?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (element.lastname?.toLowerCase().contains(query) ?? false) ||
              (element.departmentname?.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
    }
    emit(homeState);
  }

  void assignForSelection(DeviceAssignFor deviceAssignFor) {
    HomeState homeState = state.copy();
    homeState.deviceAssignForGroupValue = deviceAssignFor;
    emit(homeState);
  }

  void assignDevice({required String note}) async {
    HomeState homeState = state.copy();
    EmployeeModel? employeeModel = homeState.selectedAssignEmployee;
    if (state.deviceInfoModel?.deviceId != null) {
      bool isRegistered = await FirebaseService.instance.isDeviceRegisterInDatabase(state.deviceInfoModel?.deviceId ?? "-1");
      if (!isRegistered) {
        DeviceDataModel deviceDataModel = DeviceDataModel()
          ..deviceName = state.deviceInfoModel?.deviceName
          ..deviceId = state.deviceInfoModel?.deviceId
          ..modelName = state.deviceInfoModel?.modelName
          ..version = state.deviceInfoModel?.version
          ..os = state.deviceInfoModel?.os
          ..currentActiveUser = CurrentActiveUser(
              assignFor: homeState.deviceAssignForGroupValue.name,
              empId: employeeModel?.employeeId,
              empImage: employeeModel?.profileImage,
              firstName: employeeModel?.firstname,
              lastName: employeeModel?.lastname,
              note: note,
              createdAt: DateTime.now());

        await FirebaseService.instance.addDeviceInfo(deviceDataModel.toMap());
      }
    }
  }

  void _syncDeviceWithDatabase() async {
    DeviceInfoModel? deviceInfoModel = await DeviceInfoService.instance.getDeviceInfo();
  }

  void getDeviceInfo() async {
    HomeState homeState = state.copy();
    homeState.deviceInfoModel = await DeviceInfoService.instance.getDeviceInfo();
    emit(homeState);
  }

  void selectedAssignInfo(int id) {
    HomeState homeState = state.copy();
    homeState.selectedAssignEmployee = homeState.employeeDataList?.firstWhereOrNull((element) => element.id == id);
    emit(homeState);
  }
}
