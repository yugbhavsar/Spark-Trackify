import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spark_trackify/app/features/AssignDetailScreen/repository/assignDetailsRepository.dart';
import 'package:spark_trackify/app/features/HomeScreen/models/employee_model.dart';
import 'package:spark_trackify/app/widgets/show_toast.dart';

import '../../../core/enums/app_enum.dart';

part 'assign_details_event.dart';
part 'assign_details_state.dart';

class AssignDetailsBloc extends Bloc<AssignDetailsEvent, AssignDetailsState> {
  AssignDetailsRepository assignDetailsRepository;

  AssignDetailsBloc({required this.assignDetailsRepository}) : super(AssignDetailsState.initial()) {
    on<FetchEmployeesEvent>((event, emit) async {
      AssignDetailsState assignDetailsState = AssignDetailsState.initial();
      assignDetailsState.isLoading = true;
      emit(assignDetailsState);
      assignDetailsState = state.copy();
      try {
        assignDetailsState.employeeList = await assignDetailsRepository.fetchEmployees();
      } catch (e) {
        showToast.setMsg(e.toString());
        // assignDetailsState.errorMessage = e.toString();
        // assignDetailsState.activeStatus = ActiveStatus.error;
      }

      assignDetailsState.isLoading = false;
      emit(assignDetailsState);
    });

    on<SelectedEmployeeEvent>((event, emit) {
      AssignDetailsState assignDetailsState = state.copy();
      assignDetailsState.selectedEmployeeModel = event.selectedEmployeeModel;
      emit(assignDetailsState);
    });
  }
}
