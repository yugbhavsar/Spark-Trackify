part of 'assign_details_bloc.dart';

class AssignDetailsState {
  ActiveStatus activeStatus;
  String? errorMessage;
  bool isLoading;
  List<EmployeeModel> employeeList;
  EmployeeModel? selectedEmployeeModel;

  AssignDetailsState({
    required this.activeStatus,
    this.isLoading = false,
    this.errorMessage,
    required this.employeeList,
    this.selectedEmployeeModel,
  });

  static AssignDetailsState initial() => AssignDetailsState(activeStatus: ActiveStatus.loaded, employeeList: []);

  AssignDetailsState copy() {
    return AssignDetailsState(
      activeStatus: activeStatus,
      isLoading: isLoading,
      errorMessage: errorMessage,
      employeeList: employeeList,
      selectedEmployeeModel: selectedEmployeeModel,
    );
  }
}
