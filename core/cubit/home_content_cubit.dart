// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

enum TabType { delivery, pickup }

class CarouselCubit extends Cubit<int> {
  CarouselCubit() : super(0);

  void updateIndex(int index) {
    emit(index);
  }
}

class TabCubit extends Cubit<TabType> {
  TabCubit() : super(TabType.delivery);

  void selectDelivery() => emit(TabType.delivery);
  void selectPickup() => emit(TabType.pickup);
}
