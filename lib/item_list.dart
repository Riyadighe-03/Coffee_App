import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_app/dash_board.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  ItemList({Key? key}) : super(key: key) {
    // _stream = _reference.snapshot();
  }

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // _stream = _reference.snapshot();
  void initState() {
    super.initState();
    _reference = FirebaseFirestore.instance.collection('product_info');
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('product_info');

  late Stream<QuerySnapshot> _stream;
  final Stream<QuerySnapshot> _Stream =
      FirebaseFirestore.instance.collection('product_info').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error occurred ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            List<Map> items = documents.map((e) => e.data() as Map).toList();

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  Map thisItem = items[index];

                  return ListTile(
                    title: Text('${thisItem['name']}'),
                    subtitle: Text('${thisItem['price']}'),
                    leading: Container(
                        height: 80,
                        width: 80,
                        child: thisItem.containsKey('image')
                            ? Image.network('${thisItem['image']}')
                            : Container()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DashBoard(itemId: thisItem['id'])));
                    },
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
