import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  void authenticate() {
    Future.delayed(const Duration(seconds: 2), () {
      emit(SplashScreenInitial(navigate: SplashToNavigate.loginScreen));
    });
  }
}
