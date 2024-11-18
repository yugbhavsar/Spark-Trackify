part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginRequestedEvent extends LoginEvent {
  final String email, password;

  LoginRequestedEvent({required this.email, required this.password});
}
