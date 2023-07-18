import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../search/const_search_objects.dart';

class AddCustomerNotifier with ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone1 = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController billingAddress = TextEditingController();
  CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customer_collection');
  String validationError = "";
  List<String> customerKeys = [];
  Map<String, QueryDocumentSnapshot> customerDatas = {};

  getCustomerDataFormFirebase() async {
    // List<QueryDocumentSnapshot> queryDocumentSnapshot = [];
    try {
      // queryDocumentSnapshot.clear();
      customerDatas.clear();
      customerKeys.clear();
      QuerySnapshot? customerData = await customerCollection.get();
      // queryDocumentSnapshot.addAll(customerData.docs);
      for (QueryDocumentSnapshot doc in customerData.docs) {
        customerDatas[doc.get('firstName')] = doc;
        customerViewScreenSearchNotifierObject.insert(doc.get('firstName'));
      }
      customerViewScreenSearchNotifierObject.collectionOfDatas = customerDatas;
      customerViewScreenSearchNotifierObject.collectionOfDatsKeys
          .addAll(customerDatas.keys);
      customerKeys.addAll(customerDatas.keys);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  addCustomerToFirebase(
      {required String gender,
      required String firstName,
      required String lastName,
      required String phone,
      required String phone1,
      required String place,
      required String address,
      required String billingAddress}) async {
    Map<String, String> customerMap = {
      'gender': gender,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'phone1': phone1,
      'place': place,
      'address': address,
      'billingAddress': billingAddress,
    };
    await customerCollection.add(customerMap);
    await getCustomerDataFormFirebase();
    controllerClear();
    notifyListeners();
  }

  // textformfieldValidation(String value, int index) {
  //   if (value.isEmpty) {
  //     validationError[index] = 'This value is required';
  //   } else {
  //     validationError[index] = '';
  //   }
  //   notifyListeners();
  // }

  bool alltextformfieldValidation() {
    if (firstName.text.isEmpty) {
      validationError = 'FirstName field is required';
    } else if (lastName.text.isEmpty) {
      validationError = 'LastName field is required';
    } else if (phone.text.isEmpty) {
      validationError = 'Phone field is required';
    } else if (place.text.isEmpty) {
      validationError = 'Place field is required';
    } else if (address.text.isEmpty) {
      validationError = 'Address field is required';
    } else {
      validationError = "";
    }

    bool condition = validationError.isNotEmpty;
    if (condition) {
      notifyListeners();
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  controllerClear() {
    firstName.text = '';
    lastName.text = '';
    phone.text = '';
    phone1.text = '';
    place.text = '';
    address.text = '';
    billingAddress.text = '';
    notifyListeners();
  }
}
