import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spark_trackify/Repository/APIHelper.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  void authenticate() async {

    await FireDb.Shared.getToken((isSuccess) {
      if (isSuccess){
        setDeviceData();
        emit(SplashScreenInitial(navigate: SplashToNavigate.homeScreen ));
      }else{
        emit(SplashScreenInitial(navigate: SplashToNavigate.loginScreen ));
      }
    },);
  }

  void setDeviceData() async {
    await FireDb.Shared.setDeviceData();
  }
}
