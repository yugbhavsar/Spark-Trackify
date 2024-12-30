part of 'home_cubit.dart';

final class HomeState {
  ActiveStatus activeStatus;
  String? errorMessage;
  int selectedTab;
  bool isLoading;
  List<DeviceDataModel> deviceDataList;
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
      this.deviceInfoModel,
      this.selectedAssignEmployee,
      required this.filteredEmployeeList,
      required this.deviceDataList,
      required this.selectedTab,
      required this.deviceAssignForGroupValue,
      required this.noteController,
      required this.employeeNameController});

  static HomeState initial() => HomeState(
      activeStatus: ActiveStatus.loaded,
      filteredEmployeeList: [],
      deviceDataList: [],
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
