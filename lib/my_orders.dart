import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<DocumentSnapshot>? documents;
  late Stream<QuerySnapshot> _stream;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Orders"),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
            )),
      ),
      backgroundColor: Colors.white,
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
              documents = snapshot.data.docs;
              debugPrint("list len ${documents?.length}");
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.brown)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.asset(
                                          "assets/cold_coffee.jpeg"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          documents?[index]['product name'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(documents?[index]['product price'],
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
                                            Icons.favorite_border,
                                            color: Colors.brown,
                                          )),
                                    ],
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (context, int index) => SizedBox(
                          height: 20,
                        ),
                        itemCount: documents!.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Its Error!');
            }

            return const SizedBox();
          }),
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
