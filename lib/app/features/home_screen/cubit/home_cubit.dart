import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

    _deviceSubscription = FirebaseDatabase.instance.ref().child("deviceData").onValue.listen((event) {
      final deviceDataMap = event.snapshot.value as Map<dynamic, dynamic>?;
      log("log: ${deviceDataMap}");
      List<DeviceDataModel> deviceList = [];
      if (deviceDataMap != null) {
        deviceList = deviceDataMap.entries.map((entry) => DeviceDataModel.fromMap(entry.key, entry.value)).toList();
        log("log: ${deviceList.length}");
      }
      HomeState homeState = state.copy();
      homeState.isLoading = false;
      log("log: before state ${homeState.deviceDataList?.toString()}");
      homeState.deviceDataList = deviceList;
      log("log: after state ${homeState.deviceDataList?.toString()}");

      emit(homeState);
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
    log("log: fetchEmployeeData Called");
    emit(state.copy()..isLoading = true);

    List<EmployeeModel> employeeData = await homeRepository.getEmployeeData();
    HomeState homeState = state.copy();
    homeState.employeeDataList = employeeData;
    homeState.filteredEmployeeList = employeeData;
    homeState.isLoading = false;
    log("log: fetchEmployeeData Called ${homeState.deviceDataList}");
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
    log("log: assignForSelection Called ${homeState.deviceDataList}");
    homeState.deviceAssignForGroupValue = deviceAssignFor;
    log("log: assignForSelection Called ${homeState.deviceDataList}");
    emit(homeState);
  }

  void assignDevice() async {
    HomeState homeState = state.copy();
    EmployeeModel? employeeModel = homeState.selectedAssignEmployee;
    if (homeState.deviceAssignForGroupValue != DeviceAssignFor.unAssigned && homeState.employeeNameController.text.trim().isEmpty) {
      showToast.setMsg("Please select assignee!");
    } else if (homeState.deviceInfoModel?.deviceId != null) {
      log("log: assignDevice Called ${homeState.deviceDataList}");
      bool isRegistered = await FirebaseService.instance.isDeviceRegisterInDatabase(homeState.deviceInfoModel?.deviceId ?? "-1");
      CurrentActiveUser? currentActiveUser;
      if (homeState.deviceAssignForGroupValue != DeviceAssignFor.unAssigned) {
        currentActiveUser = CurrentActiveUser(
            assignFor: homeState.deviceAssignForGroupValue,
            empId: employeeModel?.employeeId,
            empImage: employeeModel?.profileImage,
            firstName: employeeModel?.firstname,
            lastName: employeeModel?.lastname,
            department: employeeModel?.departmentname,
            note: homeState.deviceAssignForGroupValue != DeviceAssignFor.unAssigned ? homeState.noteController.text.trim() : null,
            createdAt: DateTime.now().toIso8601String());
      }

      if (!isRegistered) {
        DeviceDataModel deviceDataModel = DeviceDataModel()
          ..deviceName = homeState.deviceInfoModel?.deviceName
          ..deviceId = homeState.deviceInfoModel?.deviceId
          ..modelName = homeState.deviceInfoModel?.modelName
          ..deviceImage = getDeviceImage(modelName: homeState.deviceInfoModel?.modelName ?? "")
          ..version = homeState.deviceInfoModel?.version
          ..os = homeState.deviceInfoModel?.os
          ..currentActiveUser = currentActiveUser;

        await FirebaseService.instance.addDeviceInfo(deviceDataModel.toMap());
      } else {
        DeviceDataModel? deviceDataModel =
            homeState.deviceDataList?.firstWhereOrNull((element) => element.deviceId == homeState.deviceInfoModel?.deviceId);
        if (deviceDataModel?.currentActiveUser != null) {
          deviceDataModel?.currentActiveUser?.deletedAt = DateTime.now().toIso8601String();
          if (deviceDataModel?.currentActiveUser?.assignFor != DeviceAssignFor.unAssigned) {
            deviceDataModel?.history?.add(deviceDataModel.currentActiveUser!);
          }
        }
        deviceDataModel?.currentActiveUser = currentActiveUser;
        if (deviceDataModel?.toMap() != null) {
          await FirebaseService.instance.updateDeviceInfo(deviceDataModel?.toMap() ?? {});
        }
      }
      String message;
      if (employeeModel?.firstname != null) {
        message =
            "${homeState.deviceInfoModel?.deviceName ?? ""} Assign to ${employeeModel?.firstname ?? ""} ${employeeModel?.lastname ?? ""}";
      } else {
        message = "Unassign ${homeState.deviceInfoModel?.deviceName ?? ""}";
      }
      showToast.setMsg(message);
      homeState.selectedTab = 0;
      homeState.employeeNameController.text = "";
      homeState.noteController.text = "";

      log("log:after assign  ${homeState.deviceDataList}");
      homeState.deviceDataList = state.deviceDataList;
      emit(homeState);
    }
  }

  void getDeviceInfo() async {
    HomeState homeState = state.copy();
    homeState.deviceInfoModel = await DeviceInfoService.instance.getDeviceInfo();
    DeviceDataModel? deviceDataModel =
        homeState.deviceDataList?.firstWhereOrNull((element) => element.deviceId == homeState.deviceInfoModel?.deviceId);
    if (deviceDataModel != null) {
      if (deviceDataModel.currentActiveUser != null) {
        homeState.employeeNameController.text =
            "${deviceDataModel.currentActiveUser?.firstName} ${deviceDataModel.currentActiveUser?.lastName}";
        homeState.noteController.text = deviceDataModel.currentActiveUser?.note ?? "";
      }
      homeState.deviceAssignForGroupValue = deviceDataModel.currentActiveUser?.assignFor ?? DeviceAssignFor.development;
    }
    emit(homeState);
  }

  void selectedAssignInfo(int id) {
    HomeState homeState = state.copy();
    log("log: assign info state ${homeState.deviceDataList}");
    homeState.selectedAssignEmployee = homeState.employeeDataList?.firstWhereOrNull((element) => element.id == id);
    emit(homeState);
  }

  @override
  Future<void> close() {
    _deviceSubscription?.cancel();
    return super.close();
  }
}
