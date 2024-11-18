part of 'login_bloc.dart';

class LoginState {
  ActiveStatus activeStatus;
  String? errorMessage;
  bool isLoading;

  LoginState({
    required this.activeStatus,
    this.isLoading = false,
    this.errorMessage,
  });

  static LoginState initial() => LoginState(activeStatus: ActiveStatus.loaded);

  LoginState copy() {
    return LoginState(
      activeStatus: activeStatus,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  }
}
