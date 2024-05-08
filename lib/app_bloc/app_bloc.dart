import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/cart_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events.dart';
part 'states.dart';

// class DashBoardBloc extends Bloc<DashboardEvent, DashboardState> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   DashBoardBloc() : super(DashboardLoading());
// }

class MyCartBloc extends Bloc<MyCartEvent, MyCartState> {
  MyCartBloc() : super(MyCartInitial()) {
    on<LoadCartItems>(loadCartItems);
    on<LoadData>(loadData);
  }

  FutureOr<void> loadCartItems(
      LoadCartItems event, Emitter<MyCartState> emit) async {
    final documents = await FirebaseFirestore.instance
        .collection("my_cart")
        .get()
        .then((value) {
      //debugPrint("got data ${value.docs.first["product name"]}"));
      emit(CartItemsLoaded(value.docs));
    });
    // debugPrint("${cartItems.}");
    // emit(CartItemsLoaded(documents));
  }

  FutureOr<void> loadData(LoadData event, Emitter<MyCartState> emit) async {
    final documents = await FirebaseFirestore.instance
        .collection("product_info")
        .get()
        .then((value) {
      debugPrint("got data  ${value.docs.first["product name"]}");
      emit(DashboardLoaded(value.docs));
    });
  }
}
