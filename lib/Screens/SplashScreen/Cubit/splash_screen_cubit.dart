import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  void authenticate() {
    print("into the splashscreen");
    Future.delayed(const Duration(seconds: 5),() {
      print("After 5 second");
      emit(SplashScreenInitial(navigate: SplashToNavigate.loginScreen ));
    },);

  }
}
