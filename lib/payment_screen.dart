import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'my_orders.dart';

Future<void> makePayment(
  context,
  List<DocumentSnapshot<Object?>>? documents,
) async {
  Map<String, dynamic>? paymentIntent;
  try {
    // Create payment intent data
    paymentIntent = await createPaymentIntent('1000', 'INR');
    // initialise the payment sheet setup
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Client secret key from payment data
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        googlePay: const PaymentSheetGooglePay(
            // Currency and country code is accourding to India
            testEnv: true,
            currencyCode: "INR",
            merchantCountryCode: "IN"),
        // Merchant Name
        merchantDisplayName: 'Flutterwings',
        // return URl if you want to add
        // returnURL: 'flutterstripe://redirect',
      ),
    );
    // Display payment sheet
    displayPaymentSheet(context, documents);
  } catch (e) {
    print("exception $e");

    if (e is StripeConfigException) {
      print("Stripe exception ${e.message}");
    } else {
      print("exception $e");
    }
  }
}

displayPaymentSheet(
  BuildContext context,
  List<DocumentSnapshot<Object?>>? documents,
) async {
  Map<String, dynamic>? paymentIntent;
  String imageUrl = '';

  try {
    // "Display payment sheet";
    await Stripe.instance.presentPaymentSheet().then((value) =>
        // ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text('Payment succesfully completed'),
        //       ),
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        size: 50,
                        color: Colors.green,
                      ),
                      // Text(
                      //   "Paid successfully",
                      //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Paid successfully",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore db = FirebaseFirestore.instance;
                      CollectionReference myOrders = db.collection('my_orders');
                      /*if (key.currentState!.validate()) {
                                  print('yess');
                                }*/
                      documents?.forEach((cartItem) {
                        final Map<String, dynamic> dataToSend = {
                          'product name': cartItem["product name"],
                          'product price': cartItem["product price"],
                          'image': imageUrl
                        };
                        myOrders.add(dataToSend).then((value) {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrders()));
                        });
                      });
                      // final Map<String, dynamic> dataToSend = {
                      //   'product name': productName,
                      //   'product price': price,
                      //   'image': imageUrl
                      // };
                      // myOrders.add(dataToSend).then((value) {
                    },
                    child: Text(
                      "Done",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ));
  } on Exception catch (e) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Unforeseen error: ${e}'),
    //   ),

    // );
    if (e is StripeException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error from Stripe: ${e.error.localizedMessage}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unforeseen error: ${e}'),
        ),
      );
    }
  }
  ;

  // Show when payment is done
  // Displaying snackbar for it

  // ScaffoldMessenger.of(context).showSnackBar(
  //   const SnackBar(content: Text("Paid successfully")),
  // );
  paymentIntent = null;
}

createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': ((int.parse(amount)) * 100).toString(),
      'currency': currency,
      'payment_method_types[]': 'card',
    };
    var secretKey =
        "sk_test_51PBxrMSC0hHfvn3QtSDdq81fix8GyvuKgEBnQxK1NVSwxRoHbyffCAlGW0huf8FOZYOpVYaJPHK8vfWnGXvuyK6T002H1TjJy8";
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    print('Payment Intent Body: ${response.body.toString()}');
    return jsonDecode(response.body.toString());
  } catch (err) {
    print('Error charging user: ${err.toString()}');
  }
}
