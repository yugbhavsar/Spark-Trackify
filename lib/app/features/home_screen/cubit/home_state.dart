part of 'home_cubit.dart';

final class HomeState {
  ActiveStatus activeStatus;
  String? errorMessage;
  int selectedTab;
  bool isLoading;
  bool isDeviceRegistered;
  List<DeviceDataModel>? deviceDataList;
  DeviceDataModel? currentDeviceData;
  List<EmployeeModel>? employeeDataList;
  List<EmployeeModel> filteredEmployeeList;
  DeviceAssignFor deviceAssignForGroupValue;
  DeviceInfoModel? deviceInfoModel;
  EmployeeModel? selectedAssignEmployee;
  TextEditingController employeeNameController;
  TextEditingController noteController;

  HomeState(
      {required this.activeStatus,
      this.errorMessage,
      this.employeeDataList,
      this.isLoading = false,
      this.isDeviceRegistered = false,
      this.deviceInfoModel,
      this.currentDeviceData,
      this.selectedAssignEmployee,
      required this.filteredEmployeeList,
      this.deviceDataList,
      required this.selectedTab,
      required this.deviceAssignForGroupValue,
      required this.noteController,
      required this.employeeNameController});

  static HomeState initial() => HomeState(
      activeStatus: ActiveStatus.loaded,
      filteredEmployeeList: [],
      selectedTab: 0,
      deviceAssignForGroupValue: DeviceAssignFor.development,
      noteController: TextEditingController(),
      employeeNameController: TextEditingController());

  HomeState copy() {
    return HomeState(
        isLoading: isLoading,
        activeStatus: activeStatus,
        errorMessage: errorMessage,
        selectedTab: selectedTab,
        currentDeviceData: currentDeviceData,
        isDeviceRegistered: isDeviceRegistered,
        selectedAssignEmployee: selectedAssignEmployee,
        deviceDataList: deviceDataList,
        filteredEmployeeList: filteredEmployeeList,
        employeeDataList: employeeDataList,
        deviceAssignForGroupValue: deviceAssignForGroupValue,
        deviceInfoModel: deviceInfoModel,
        noteController: noteController,
        employeeNameController: employeeNameController);
  }
}
