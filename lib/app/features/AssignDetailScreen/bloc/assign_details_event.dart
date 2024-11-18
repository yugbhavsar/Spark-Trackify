part of 'assign_details_bloc.dart';

@immutable
sealed class AssignDetailsEvent {}

final class FetchEmployeesEvent extends AssignDetailsEvent {}

final class SelectedEmployeeEvent extends AssignDetailsEvent {
  final EmployeeModel? selectedEmployeeModel;

  SelectedEmployeeEvent({this.selectedEmployeeModel});
}
