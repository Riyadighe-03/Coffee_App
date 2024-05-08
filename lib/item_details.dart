import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/cart_items.dart';
import 'package:coffee_app/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import 'counter_cubit.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({super.key, required this.productName, required this.price});

  String productName;
  String price;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  String imageUrl = '';

  get index => null;

  // get myCart => null;
  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.productName);
    // debugPrint(widget.price);

    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Image.asset("assets/Fancy-Coffee.jpg",
            height: 450, width: 400, fit: BoxFit.cover),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              const SizedBox(
                height: 335,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.star,
                            color: Colors.brown,
                          ),
                          label: Text(
                            "4.3",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.brown),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.productName}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.brown[700]),
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              // icon: const Icon(
                              //   Icons.star,
                              //   color: Colors.brown,
                              // ),
                              child: Text(
                                '${widget.price}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.brown),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "Coffee size",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.brown[700]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text("Small",
                                    style: TextStyle(color: Colors.brown))),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text("Medium",
                                    style: TextStyle(color: Colors.brown))),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text("Large",
                                    style: TextStyle(color: Colors.brown))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        "About",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.brown[700]),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ReadMoreText(
                        'In comparison to a cafe latte, perfect cappuccino has a more intense coffee flavour, as well as, cappuccino’s silky magic is beyond the grasp of home baristas. It’s just too delicate of a dance, best left to the cafe. ',
                        trimMode: TrimMode.Line,
                        trimLines: 2,
                        colorClickableText: Colors.brown,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      // child: Text(
                      //   "In comparison to a cafe latte, perfect cappuccino has a more intense coffee flavour, as well as",
                      //   style: TextStyle(
                      //       // fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //       color: Colors.black),
                      // ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Volume ",
                            style: TextStyle(color: Colors.brown, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "160ml",
                            style: TextStyle(
                                color: Colors.brown.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.brown)),
                              child: BlocBuilder<CounterCubit, int>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      IconButton(
                                          onPressed: () => context
                                              .read<CounterCubit>()
                                              .decrement(),
                                          icon: const Icon(Icons.remove)),
                                      Text(
                                        '$count',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () => context
                                              .read<CounterCubit>()
                                              .increment(),
                                          icon: const Icon(Icons.add)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                                size: 45,
                                color: Colors.brown,
                              )),
                          Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.brown),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyCart(
                                              productName: [index].toString(),
                                              price: [index].toString(),
                                            )));*/

                                FirebaseFirestore db =
                                    FirebaseFirestore.instance;
                                CollectionReference myCart =
                                    db.collection('my_cart');
                                /*if (key.currentState!.validate()) {
                                  print('yess');
                                }*/
                                final Map<String, dynamic> dataToSend = {
                                  'product name': widget.productName,
                                  'product price': widget.price,
                                  'image': imageUrl
                                };
                                myCart.add(dataToSend).then((value) {
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyCart()));
                                });
                                // await productInfo
                                //     .doc('product_info')
                                //     .set(productInfoMap)
                                //     .then((value) => debugPrint("success"))
                                //     .onError((error, stackTrace) => debugPrint(
                                //         "error ${error.toString()}"));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                              ),
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.white,
                          size: 45,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 40,
                        ))
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
