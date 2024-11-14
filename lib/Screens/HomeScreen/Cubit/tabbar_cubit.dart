import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tabbar_state.dart';

class TabbarCubit extends Cubit<TabbarState> {
  TabbarCubit() : super(TabbarInitial());

  void tabBarClick(int index) {
    emit(TabbarInitial(selectedTab: index));
  }
}
