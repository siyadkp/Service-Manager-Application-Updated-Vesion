import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../search/const_search_objects.dart';

File? photo;

class AdminAddProductNotifier with ChangeNotifier {
  Map<String, QueryDocumentSnapshot> productDatas = {};
  List<String> productsKeys = [];
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('product_collection');
  TextEditingController productName = TextEditingController();
  TextEditingController serialNumber = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController wholesalePrice = TextEditingController();
  TextEditingController retailPrice = TextEditingController();
  TextEditingController totalPrice = TextEditingController();

  List<String> validationError = ['', '', '', '', '', ''];
  String imageUri='';

  addImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? xPhoto = await picker.pickImage(source: ImageSource.gallery);
      photo = File(xPhoto!.path);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getProductDataFormFirebase() async {
    List<QueryDocumentSnapshot> queryDocumentSnapshot = [];
    try {
      queryDocumentSnapshot.clear();
      productDatas.clear();
      QuerySnapshot? productData = await usersCollection.get();
      queryDocumentSnapshot.addAll(productData.docs);
      for (QueryDocumentSnapshot doc in productData.docs) {
        productDatas[doc.get('productName')] = doc;
        productsViewScreenSearchNotifierObject.insert(doc.get('productName'));
      }
      productsViewScreenSearchNotifierObject.collectionOfDatas = productDatas;
      productsViewScreenSearchNotifierObject.collectionOfDatsKeys
          .addAll(productDatas.keys);
      productsKeys.addAll(productDatas.keys);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  addProductToFirebase({
    required String productName,
    required String serialNumber,
    required String qty,
    required String wholesalePrice,
    required String retailPrice,
    required String totalPrice,
  }) async {
    await cloudAdd(photo!);
    Map<String, String> productMap = {
      'productName': productName,
      'serialNumber': serialNumber,
      'qty': qty,
      'wholesalePrice': wholesalePrice,
      'retailPrice': retailPrice,
      'totalPrice': totalPrice,
      'photo': imageUri
    };
    await usersCollection.add(productMap);
    await getProductDataFormFirebase();
    controllerClear();
    notifyListeners();
  }
Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    imageUri = downloadUrl;
    notifyListeners();
  }
  totalPriceCalculating() {
    if (wholesalePrice.text.isNotEmpty && qty.text.isNotEmpty) {
      totalPrice.text =
          (int.parse(wholesalePrice.text) * int.parse(qty.text)).toString();
      notifyListeners();
    }
  }

  textformfieldValidation(String value, int Index) {
    if (value.isEmpty) {
      validationError[Index] = 'This value is required';
    } else {
      validationError[Index] = '';
    }
    notifyListeners();
  }

  bool alltextformfieldValidation() {
    if (productName.text.isEmpty) {
      validationError[0] = 'This value is required';
    } else {
      validationError[0] = '';
    }
    if (serialNumber.text.isEmpty) {
      validationError[1] = 'This value is required';
    } else {
      validationError[1] = '';
    }
    if (qty.text.isEmpty) {
      validationError[2] = 'This value is required';
    } else {
      validationError[2] = '';
    }
    if (wholesalePrice.text.isEmpty) {
      validationError[3] = 'This value is required';
    } else {
      validationError[3] = '';
    }
    if (retailPrice.text.isEmpty) {
      validationError[4] = 'This value is required';
    } else {
      validationError[4] = '';
    }
    if (totalPrice.text.isEmpty) {
      validationError[5] = 'This value is required';
    } else {
      validationError[5] = '';
    }
    bool condition = validationError.contains('This value is required');
    if (condition) {
      notifyListeners();
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  controllerClear() {
    productName.text = '';
    serialNumber.text = '';
    qty.text = '';
    wholesalePrice.text = '';
    retailPrice.text = '';
    totalPrice.text = '';
    photo = null;
    notifyListeners();
  }
}
