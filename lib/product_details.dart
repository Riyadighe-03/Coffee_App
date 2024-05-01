import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  String imageUrl = '';

  get productName => null;

  get productPrice => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Product",
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
              )),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/stepper.png",
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Product",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const Text(
                            "You can add upto 3 products for your collection.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                if (imageUrl.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Please upload an image'),
                                  ));
                                }

                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.camera);
                                print('${file?.path}');

                                if (file == null) return;

                                String uniqueFileName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();

                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImage =
                                    referenceRoot.child('images');

                                Reference refrenceImageToUpload =
                                    referenceDirImage.child(uniqueFileName);

                                try {
                                  await refrenceImageToUpload
                                      .putFile(File(file!.path));
                                  imageUrl = await refrenceImageToUpload
                                      .getDownloadURL();
                                } catch (error) {}
                              },
                              icon: const Icon(Icons.add_a_photo_outlined)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Form(
                            key: key,
                            child: Column(children: [
                              TextFormField(
                                controller: productNameController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Product Name',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: productPriceController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Price (Rs)',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.add_box_outlined),
                                    onPressed: () {},
                                  ),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Add Size',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.brown,
                                    onPressed: () {},
                                    mini: true,
                                    child: const Icon(Icons.add,
                                        color: Colors.white, size: 25),
                                  ),
                                  Text(
                                    "ADD MORE PRODUCT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.brown[700]),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.brown),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        FirebaseFirestore db =
                                            FirebaseFirestore.instance;
                                        CollectionReference productInfo =
                                            db.collection('product_info');
                                        if (key.currentState!.validate()) {
                                          print('yess');
                                        }
                                        final Map<String, dynamic> dataToSend =
                                            {
                                          'product name':
                                              productNameController.text,
                                          'product price':
                                              productPriceController.text,
                                          'image': imageUrl
                                        };
                                        productInfo.add(dataToSend);
                                        // await productInfo
                                        //     .doc('product_info')
                                        //     .set(productInfoMap)
                                        //     .then((value) =>
                                        //         debugPrint("success"))
                                        //     .onError((error, stackTrace) =>
                                        //         debugPrint(
                                        //             "error ${error.toString()}"));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown,
                                      ),
                                      child: const Text(
                                        "ADD NOW",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
