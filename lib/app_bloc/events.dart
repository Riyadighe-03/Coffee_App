part of 'app_bloc.dart';

abstract class MyCartEvent {}

class InitialEvent extends MyCartEvent {
  InitialEvent();
}

class LoadCartItems extends MyCartEvent {
  LoadCartItems();
}

class LoadData extends MyCartEvent {
  LoadData();
}

class ItemSelected extends MyCartEvent {
  final int index;

  ItemSelected(this.index);
}
