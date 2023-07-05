import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


import '../search/const_search_objects.dart';

class AddNewServiceCallNotifier with ChangeNotifier {
  TextEditingController customer = TextEditingController();
  TextEditingController productCategory = TextEditingController();
  
  TextEditingController product = TextEditingController();
  TextEditingController complaint = TextEditingController();
  TextEditingController serialNumber = TextEditingController();
  TextEditingController description = TextEditingController();
  String? status;
  CollectionReference callCollection =
      FirebaseFirestore.instance.collection('call_collection');
  CollectionReference jobNumber =
      FirebaseFirestore.instance.collection('job_number');
  bool isWorked = true;
  List<String> validationError = [
    '',
    '',
    '',
    '',
    '',
  ];
  Map<String, QueryDocumentSnapshot> collectionOfDatas =
      customerViewScreenSearchNotifierObject.collectionOfDatas;
  List<String> callDataKeys = [];
  Map<String, QueryDocumentSnapshot> callDatas = {};
  String? _currentjobnumber;

  getServiceDataFormFirebase() async {
    List<QueryDocumentSnapshot> queryDocumentSnapshot = [];
    try {
      queryDocumentSnapshot.clear();
      callDatas.clear();
      callDataKeys = [];
      serviceCallViewScreenSearchNotifierObject.collectionOfDatas = {};
      serviceCallViewScreenSearchNotifierObject.collectionOfDatsKeys = [];
      if (isWorked) {
        DocumentReference? jobNumberDoc = jobNumber.doc("KktKIyTkv43TOmMZjF3i");
        DocumentSnapshot snapshot = await jobNumberDoc.get();
        _currentjobnumber = snapshot.get('currentjobnumber');
        isWorked = false;
      }

      QuerySnapshot? serviceCallData = await callCollection.get();

      queryDocumentSnapshot.addAll(serviceCallData.docs);
      for (QueryDocumentSnapshot doc in serviceCallData.docs) {
        callDatas[doc.get('customer')] = doc;
        serviceCallViewScreenSearchNotifierObject.insert(doc.get('customer'));
      }
      serviceCallViewScreenSearchNotifierObject.collectionOfDatas = callDatas;
      serviceCallViewScreenSearchNotifierObject.collectionOfDatsKeys
          .addAll(callDatas.keys);
      callDataKeys.addAll(callDatas.keys);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  addNewCallToFirebase({
    required String type,
    required String productCategory,
    required String date,
    required String product,
    required String complaint,
    required String serialNumber,
    required String description,
  }) async {
    _currentjobnumber = (int.parse(_currentjobnumber!) + 1).toString();
    DocumentReference docRef = jobNumber.doc("KktKIyTkv43TOmMZjF3i");
    docRef.update({
      'currentjobnumber': _currentjobnumber,
    });

    Map<String, String> customerMap = {
      'jobnumber': _currentjobnumber!,
      'status': 'Pending',
      'type': type,
      'customer': customer.text,
      'productCategory': productCategory,
      'date': date,
      'updatedDate': '',
      'product': product,
      'complaint': complaint,
      'serialNumber': serialNumber,
      'description': description,
      'service': '',
      'amount': ''
    };
    await callCollection.add(customerMap);
    await getServiceDataFormFirebase();
    controllerClear();
    notifyListeners();
  }

  textformfieldValidation(String value, int index) {
    print(collectionOfDatas.containsKey(value));
    if (index == 0) {
      if (value.isEmpty) {
        validationError[index] = 'This value is required';
      } else if (!collectionOfDatas.containsKey(value)) {
        validationError[index] = 'Unown Customer';
      } else {
        validationError[index] = '';
      }
      notifyListeners();
    } else {
      if (value.isEmpty) {
        validationError[index] = 'This value is required';
      } else {
        validationError[index] = '';
      }
      notifyListeners();
    }
  }

  bool alltextformfieldValidation() {
    if (customer.text.isEmpty) {
      validationError[0] = 'This value is required';
    } else {
      validationError[0] = '';
    }
    if (productCategory.text.isEmpty) {
      validationError[1] = 'This value is required';
    } else {
      validationError[1] = '';
    }
    if (product.text.isEmpty) {
      validationError[3] = 'This value is required';
    } else {
      validationError[3] = '';
    }
    if (complaint.text.isEmpty) {
      validationError[4] = 'This value is required';
    } else {
      validationError[4] = '';
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
    customer.text = '';
    productCategory.text = '';
    product.text = '';
    complaint.text = '';
    serialNumber.text = '';
    description.text = '';

    notifyListeners();
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      serialNumber.text = barcodeScanRes;
      notifyListeners();
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
