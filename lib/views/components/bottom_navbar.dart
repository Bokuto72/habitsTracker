
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbar extends Cubit<int> {
  BottomNavbar() : super(0);

  void updateIndex(int index) => emit(index);

  void getDashboard() => emit(0);
  void getTasks() => emit(1);
  void getAgenda() => emit(2);
  void getRewards() => emit(3);
}