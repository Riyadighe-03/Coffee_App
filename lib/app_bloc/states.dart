// import 'package:cloud_firestore/cloud_firestore.dart';

part of 'app_bloc.dart';

abstract class MyCartState {}

class MyCartInitial extends MyCartState {
  MyCartInitial();
}

class CartItemsLoaded extends MyCartState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? cartItems;

  CartItemsLoaded(this.cartItems);
}

class DashboardLoading extends MyCartState {}

class DashboardLoaded extends MyCartState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? documents;

  DashboardLoaded(this.documents);
}

class DashboardError extends MyCartState {
  final String message;

  DashboardError(this.message);
}
