part of 'tabbar_cubit.dart';

@immutable
sealed class TabbarState {}

final class TabbarInitial extends TabbarState {

  final int selectedTab;

  TabbarInitial({ this.selectedTab = 0 });

}
