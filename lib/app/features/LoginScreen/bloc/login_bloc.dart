import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spark_trackify/app/data/utils/app_preference.dart';
import 'package:spark_trackify/app/features/LoginScreen/repository/loginRepository.dart';
import 'package:spark_trackify/app/widgets/show_toast.dart';

import '../../../core/enums/app_enum.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginState.initial()) {
    on<LoginRequestedEvent>((event, emit) async {
      LoginState loginState = LoginState.initial();
      loginState.isLoading = true;
      emit(loginState);
      loginState = state.copy();

      try {
        if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
          String token = await loginRepository.loginRequest(email: event.email, password: event.password);
          await AppPreference.instance.setString("token", token);
          loginState.activeStatus = ActiveStatus.action;
        } else {
          throw "Login credentials can't be empty!";
        }
      } catch (e) {
        log("log: ${e.toString()}");
        showToast.setMsg(e.toString());
      }

      loginState.isLoading = false;
      emit(loginState);
    });
  }
}
