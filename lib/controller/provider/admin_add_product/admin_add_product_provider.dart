import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../search/const_search_objects.dart';

File? photo;
  String currentPhotoPathInString="";
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

  String validationError = "";
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
      productsKeys.clear();
       productsViewScreenSearchNotifierObject.collectionOfDatsKeys.clear();
       productsViewScreenSearchNotifierObject.collectionOfDatas .clear();
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
    notifyListeners();
  }

  addProductToFirebase({
    required String productName,
    required String serialNumber,
    required String qty,
    required String wholesalePrice,
    required String retailPrice,
    required String totalPrice,
    
  }) async {
    if(photo!=null){
  await cloudAdd(photo!);
    }
  
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

  deleteProduct(String docId)async{
    usersCollection.doc(docId).delete();
    await getProductDataFormFirebase();
  }
   updateProductData(
      {required String key,
      required String productName,
    required String serialNumber,
    required String qty,
    required String wholesalePrice,
    required String retailPrice,
    required String totalPrice,
     }) async {
    DocumentReference docRef = usersCollection.doc(key);
    await docRef.update({
      'productName': productName,
      'serialNumber': serialNumber,
      'qty': qty,
      'wholesalePrice': wholesalePrice,
      'retailPrice': retailPrice,
      'totalPrice': totalPrice,
    });
  await getProductDataFormFirebase();
  
  }
  productDataLoadingForEditingScreen(QueryDocumentSnapshot productData) { 
    currentPhotoPathInString=productData.get('photo');
    productName.text = productData.get('productName');
    serialNumber.text = productData.get('serialNumber');
    qty.text = productData.get('qty');
    wholesalePrice.text = productData.get('wholesalePrice');
    retailPrice.text = productData.get('retailPrice');
    totalPrice.text = productData.get('totalPrice');
  }

Future<String> cloudAdd(File file) async {
    final Reference storegeref = FirebaseStorage.instance
        .ref()
        .child('image/${DateTime.now().millisecond}');
    final UploadTask uploadTask = storegeref.putFile(file);
    TaskSnapshot snap = await uploadTask;
    final String dowloadUrl = await snap.ref.getDownloadURL();
    imageUri=dowloadUrl;
    notifyListeners();
    return dowloadUrl;
  }

  totalPriceCalculating() {
    if (wholesalePrice.text.isNotEmpty && qty.text.isNotEmpty) {
      totalPrice.text =
          (int.parse(wholesalePrice.text) * int.parse(qty.text)).toString();
      notifyListeners();
    }
  }



  bool alltextformfieldValidation() {
    if (productName.text.isEmpty) {
      validationError = "ProductName is required";
    } 
   else if (qty.text.isEmpty) {
      validationError = "Qty is required";
    } 
    else if (wholesalePrice.text.isEmpty) {
      validationError = "WholesalePrice is required";
    }
    else if (retailPrice.text.isEmpty) {
      validationError = "Retail Price is required";
    }
    else if (totalPrice.text.isEmpty) {
      validationError = "Total Price is required";
    } else {
      validationError = "";
      notifyListeners();
      return true;
    }
    notifyListeners();
   return false;
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
