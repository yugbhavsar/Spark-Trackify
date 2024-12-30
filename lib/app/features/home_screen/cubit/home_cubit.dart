import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:spark_trackify/app/data/utils/app_utils.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/features/home_screen/models/device_info_model.dart';
import 'package:spark_trackify/app/features/home_screen/models/employee_model.dart';
import 'package:spark_trackify/app/features/home_screen/repository/home_repository.dart';
import 'package:spark_trackify/app/widgets/show_toast.dart';

import '../../../core/enums/app_enum.dart';
import '../../../data/services/device_info_service.dart';
import '../../../data/services/firebase_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository;
  StreamSubscription? _deviceSubscription;

  HomeCubit(this.homeRepository) : super(HomeState.initial());

  void tabBarClick(int index) {
    HomeState homeState = state.copy();
    homeState.selectedTab = index;
    emit(homeState);
  }

  void fetchDeviceData() async {
    emit(state.copy()..isLoading = true);

    List<DeviceDataModel> deviceList = [];
    _deviceSubscription = FirebaseDatabase.instance.ref().child("deviceData").onValue.listen((event) {
      final deviceDataMap = event.snapshot.value as Map<dynamic, dynamic>?;
      if (deviceDataMap != null) {
        deviceList = deviceDataMap.entries.map((entry) => DeviceDataModel.fromMap(entry.key, entry.value)).toList();
      }
      emit(state.copy()
        ..deviceDataList = deviceList
        ..isLoading = false);
    });
  }

  // void fetchDeviceData() async {
  //   HomeState homeState = state.copy();
  //   homeState.isLoading = true;
  //   emit(homeState);
  //   homeState = state.copy();
  //
  //   List<DeviceDataModel> deviceList = [];
  //   _deviceSubscription = FirebaseDatabase.instance.ref().child("deviceData").onValue.listen((event) {
  //     final deviceDataMap = event.snapshot.value as Map<dynamic, dynamic>?;
  //     if (deviceDataMap != null) {
  //       deviceDataMap.forEach((key, value) {
  //         deviceList.add(DeviceDataModel.fromMap(key, value));
  //       });
  //       homeState.deviceDataList = deviceList;
  //       emit(homeState);
  //     }
  //   });
  //
  //   homeState.isLoading = false;
  //   emit(homeState);
  // }

  // void fetchEmployeeData() async {
  //   HomeState homeState = state.copy();
  //   homeState.isLoading = true;
  //   emit(homeState);
  //   homeState = state.copy();
  //   List<EmployeeModel> employeeData = await homeRepository.getEmployeeData();
  //   homeState.employeeDataList = employeeData;
  //   homeState.filteredEmployeeList = employeeData;
  //   homeState.isLoading = false;
  //   emit(homeState);
  // }

  void fetchEmployeeData() async {
    emit(state.copy()..isLoading = true);

    List<EmployeeModel> employeeData = await homeRepository.getEmployeeData();
    emit(state.copy()
      ..employeeDataList = employeeData
      ..filteredEmployeeList = employeeData
      ..isLoading = false);
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
      CurrentActiveUser currentActiveUser = CurrentActiveUser(
          assignFor: homeState.deviceAssignForGroupValue,
          empId: employeeModel?.employeeId,
          empImage: employeeModel?.profileImage,
          firstName: employeeModel?.firstname,
          lastName: employeeModel?.lastname,
          department: employeeModel?.departmentname,
          note: note,
          createdAt: DateTime.now());

      if (!isRegistered) {
        DeviceDataModel deviceDataModel = DeviceDataModel()
          ..deviceName = state.deviceInfoModel?.deviceName
          ..deviceId = state.deviceInfoModel?.deviceId
          ..modelName = state.deviceInfoModel?.modelName
          ..deviceImage = AppUtils.getDeviceImage(modelName: state.deviceInfoModel?.modelName ?? "")
          ..version = state.deviceInfoModel?.version
          ..os = state.deviceInfoModel?.os
          ..currentActiveUser = currentActiveUser;

        await FirebaseService.instance.addDeviceInfo(deviceDataModel.toMap());
      } else {
        DeviceDataModel? deviceDataModel =
            homeState.deviceDataList.firstWhereOrNull((element) => element.deviceId == state.deviceInfoModel?.deviceId);
        if (deviceDataModel?.currentActiveUser != null) {
          deviceDataModel?.currentActiveUser?.deletedAt = DateTime.now();
          deviceDataModel?.history?.add(deviceDataModel.currentActiveUser!);
        }
        deviceDataModel?.currentActiveUser = currentActiveUser;
        if (deviceDataModel?.toMap() != null) {
          await FirebaseService.instance.updateDeviceInfo(deviceDataModel?.toMap() ?? {});
        }
      }

      showToast.setMsg("Assign to ${employeeModel?.firstname} ${employeeModel?.lastname}");
      homeState.selectedTab = 0;
    }
    emit(homeState);
  }

  void getDeviceInfo() async {
    HomeState homeState = state.copy();
    homeState.deviceInfoModel = await DeviceInfoService.instance.getDeviceInfo();
    log("log: ${homeState.deviceInfoModel?.toString()}");
    emit(homeState);
  }

  void selectedAssignInfo(int id) {
    HomeState homeState = state.copy();
    homeState.selectedAssignEmployee = homeState.employeeDataList?.firstWhereOrNull((element) => element.id == id);
    emit(homeState);
  }

  @override
  Future<void> close() {
    _deviceSubscription?.cancel();
    return super.close();
  }
}
