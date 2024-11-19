part of 'splash_screen_cubit.dart';

@immutable
sealed class SplashScreenState {}

final class SplashScreenInitial extends SplashScreenState {

  final SplashToNavigate navigate;

  SplashScreenInitial({this.navigate = SplashToNavigate.splashScreen });

}

enum SplashToNavigate {

  splashScreen,
  loginScreen,
  homeScreen

}