import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/item_details.dart';
import 'package:coffee_app/product_details.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, this.itemId});

  final String? itemId;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;

  static get documents => null;

  get productInfo => null;

  get myCart => null;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late Stream<QuerySnapshot> _stream;

  final db = FirebaseFirestore.instance;

  // List<Map> items = documents.map((e) => e.data() as Map).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Los Vegas"),
        backgroundColor: Colors.white,
        leading: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            "assets/profile.png",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: SearchAnchor(builder:
                    (BuildContext context, SearchController controller) {
                  return SearchBar(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 21.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    hintText: "Search",
                    leading: const Icon(Icons.search),
                  );
                }, suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return List<ListTile>.generate(5, (int index) {
                    final String item = 'item $index';
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                }),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Categories",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.brown[700]),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Cappuccino",
                            style: TextStyle(color: Colors.brown))),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Latte",
                            style: TextStyle(color: Colors.brown))),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text("Espresso",
                            style: TextStyle(color: Colors.brown))),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('my_cart')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      print("on error ${snapshot.hasError}");
                      return Center(
                        child: Text('Some error occurred ${snapshot.error}'),
                      );
                    }
                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;
                      debugPrint("list len ${documents.length}");
                      return CarouselSlider.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index, int a) {
                          return GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemDetails(
                                            productName: documents[index]
                                                ["product name"],
                                            price: documents[index]
                                                ['product price'],
                                          )));
                              await myCart
                                  .doc('myCart')
                                  .set()
                                  .then((value) => debugPrint("success"))
                                  .onError((error, stackTrace) =>
                                      debugPrint("error ${error.toString()}"));
                            },
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  width: 400,
                                  height: 400,
                                  margin: EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.brown.shade800),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 180,
                                        ),
                                        Text(
                                          documents[index]['product name'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: Icon(Icons.star,
                                                color: Colors.brown),
                                            label: Text(
                                              "4.3",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.brown),
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Volume",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        "160ml",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    documents[index]
                                                        ['product price'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              FloatingActionButton(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetails()));
                                                },
                                                child: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 38,
                                  child: Container(
                                    height: 180,
                                    width: 180,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/coffeee.jpeg"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                            height: 500,
                            enlargeCenterPage: true,
                            autoPlay: false,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            }),
                      );
                      return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: documents
                              .map((doc) => Card(
                                    child: ListTile(
                                      title: Text(doc['product name']),
                                      subtitle: Text(doc['product price']),
                                    ),
                                  ))
                              .toList());
                    } else if (snapshot.hasError) {
                      return Text('Its Error!');
                    }

                    return const SizedBox();
                    //   },
                    // ),
                    // print("on has data ${querySnapshot}");

                    List<Map> items =
                        documents.map((e) => e.data() as Map).toList();
                    // snapshot.data!.docs.map((DocumentSnapshot document) {
                    //   Map<String, dynamic> data =
                    //       document.data()! as Map<String, dynamic>;

                    //                 return ListView(
                    //                 children: documents.map((doc) => Card(
                    //                 child: ListTile(
                    //                   title: Text('${thisItem['name']}'),
                    //                   subtitle: Text('${thisItem['price']}'),
                    //                   leading: Container(
                    //                       height: 80,
                    //                       width: 80,
                    //                       child: thisItem.containsKey('image')
                    //                           ? Image.network('${thisItem['image']}')
                    //                           : Container()),
                    //                   onTap: () {
                    //                     Navigator.of(context).push(MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             DashBoard(itemId: thisItem['id'])));
                    //                   },
                    //                 ),
                    //               )
                    //               ),
                    //             });
                    //           });
                    //     }
                    //     return const SizedBox();
                    //   },
                    // ),
                    /*CarouselSlider.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index, int a) {
                  Map thisItem = items[index];
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 400,
                        height: 400,
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.brown.shade800,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 180,
                              ),
                              Text(
                                "${thisItem['name']}'",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton.icon(
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
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Volume",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "160ml",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "${thisItem['price']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetails()));
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 38,
                        child: Container(
                          height: 180,
                          width: 180,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage("assets/coffeee.jpeg"),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                    height: 500,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    }),
              ),*/
                  })
            ]),
      )),
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
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
