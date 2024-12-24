import 'package:bloc/bloc.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';

import '../../../data/services/firebase_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(selectedTab: 0, deviceDataList: []));

  void tabBarClick(int index) {
    emit(HomeState(selectedTab: index, deviceDataList: state.deviceDataList));
  }

  void fetchDeviceData() async {
    List<DeviceDataModel> deviceDataList = await FirebaseService.instance.getDeviceList();

    emit(HomeState(deviceDataList: deviceDataList));
  }
}
