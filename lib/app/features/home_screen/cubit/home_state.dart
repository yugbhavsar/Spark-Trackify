part of 'home_cubit.dart';

final class HomeState {
  int selectedTab;
  List<DeviceDataModel> deviceDataList;

  HomeState({this.selectedTab = 0, required this.deviceDataList});
}
