import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/cart_items.dart';
import 'package:coffee_app/item_details.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  MyCart({super.key, this.itemId});

  final String? itemId;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late Stream<QuerySnapshot> _stream;

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart"),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
            )),
      ),
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Promo Code",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Sub Total:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Shipping:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Total:",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.brown),
                  ),
                  child: const Text(
                    "Confirm Order",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('my_cart').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print("on error ${snapshot.hasError}");
              return Center(
                child: Text('Some error occurred ${snapshot.error}'),
              );
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              debugPrint("list len ${documents.length}");
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 90,
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset("assets/cold_coffee.jpeg"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  documents[index]['product name'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(documents[index]['product price'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 5,
                          right: 5,
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.brown.shade800,
                                  )),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.brown, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove,
                                        )),
                                    Text(
                                      "1",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add)),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  separatorBuilder: (context, int index) => SizedBox(
                    height: 20,
                  ),
                  itemCount: cartItems.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Its Error!');
            }

            return const SizedBox();
          }),
      // body: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: ListView.separated(
      //     itemBuilder: (context, index) => Stack(
      //       children: [
      //         Container(
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           child: Row(
      //             children: [
      //               Container(
      //                 height: 100,
      //                 width: 90,
      //                 decoration: BoxDecoration(
      //                   // color: Colors.grey,
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 child: Image.asset("assets/cold_coffee.jpeg"),
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     "Cold Coffee",
      //                     style: TextStyle(
      //                         fontSize: 16, fontWeight: FontWeight.bold),
      //                   ),
      //                   SizedBox(
      //                     height: 5,
      //                   ),
      //                   Text("Rs. 200",
      //                       style: TextStyle(
      //                           fontSize: 16, fontWeight: FontWeight.bold)),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //         Positioned(
      //             top: 5,
      //             right: 5,
      //             child: Column(
      //               children: [
      //                 IconButton(
      //                     onPressed: () {},
      //                     icon: Icon(
      //                       Icons.delete_outline,
      //                       color: Colors.brown.shade800,
      //                     )),
      //                 Container(
      //                   height: 35,
      //                   decoration: BoxDecoration(
      //                     border: Border.all(color: Colors.brown, width: 2),
      //                     borderRadius: BorderRadius.circular(20),
      //                   ),
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.end,
      //                     children: [
      //                       IconButton(
      //                           onPressed: () {},
      //                           icon: Icon(
      //                             Icons.remove,
      //                           )),
      //                       Text(
      //                         "1",
      //                         style: const TextStyle(
      //                             fontSize: 20, fontWeight: FontWeight.bold),
      //                       ),
      //                       IconButton(
      //                           onPressed: () {}, icon: const Icon(Icons.add)),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ))
      //       ],
      //     ),
      //     separatorBuilder: (context, int index) => SizedBox(
      //       height: 20,
      //     ),
      //     itemCount: cartItems.length,
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
