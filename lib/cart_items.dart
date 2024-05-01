import 'package:flutter/material.dart';

class CartItems {
  int price;
  String product;

  CartItems({required this.price, required this.product});
}

List<CartItems> cartItems = [
  CartItems(price: 200, product: "Cold Coffee"),
  CartItems(price: 100, product: "Hot Coffee"),
];
