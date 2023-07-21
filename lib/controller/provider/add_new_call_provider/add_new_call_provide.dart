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
  int pending = 0;
  int complete = 0;
  CollectionReference callCollection =
      FirebaseFirestore.instance.collection('call_collection');
  CollectionReference jobNumber =
      FirebaseFirestore.instance.collection('job_number');
  bool isWorked = true;
  String validationError = "";
  Map<String, Map<String, QueryDocumentSnapshot>> userBasedCallDatas = {};
  Map<String, QueryDocumentSnapshot> collectionOfDatas =
      customerViewScreenSearchNotifierObject.collectionOfDatas;
  List<String> callDataKeys = [];
  Map<String, QueryDocumentSnapshot> callDatas = {};
  String? _currentjobnumber;

  Future<void> getServiceDataFromFirebase() async {
    try {
      callDatas.clear();
      callDataKeys = [];
      pending = 0;
      complete = 0;
      QuerySnapshot serviceCallData = await callCollection.get();

      for (QueryDocumentSnapshot doc in serviceCallData.docs) {
        String customer = doc.get('customer');
        String docId = doc.id;
        callDatas.putIfAbsent(docId, () => doc);
        serviceCallViewScreenSearchNotifierObject.insert(docId);
        if (doc.get('status') == "Complete") {
          userBasedCallDatas.putIfAbsent(customer, () => {});
          userBasedCallDatas[customer]?.putIfAbsent(docId, () => doc);
          complete++;
        } else if (doc.get('status') == "Pending") {
          pending++;
        }
      }

      callDataKeys.addAll(callDatas.keys);

      if (isWorked) {
        DocumentReference jobNumberDoc = jobNumber.doc("KktKIyTkv43TOmMZjF3i");
        DocumentSnapshot snapshot = await jobNumberDoc.get();
        _currentjobnumber = snapshot.get('currentjobnumber');
        isWorked = false;
      }
    } catch (error) {
      // Handle any errors that occur during the execution of the code
      print('An error occurred: $error');
    }
    notifyListeners();
  }

  serviceCallCustomerUpdating(
      String oldCustomerValue, String updatedCustomerValue) async {
    try {
      callDatas.clear();
      callDataKeys = [];
      QuerySnapshot serviceCallData = await callCollection.get();

      for (QueryDocumentSnapshot doc in serviceCallData.docs) {
        String customer = doc.get('customer');
        String docId = doc.id;
        if (oldCustomerValue == customer) {
          DocumentReference docRef = callCollection.doc(docId);
          await docRef.update({
            'customer': updatedCustomerValue,
          });
        }

        callDatas.putIfAbsent(docId, () => doc);
        serviceCallViewScreenSearchNotifierObject.insert(docId);
      }

      callDataKeys.addAll(callDatas.keys);
    } catch (e) {}
    notifyListeners();
  }

  addNewCallToFirebase({
    required String customerName,
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
    await docRef.update({
      'currentjobnumber': _currentjobnumber,
    });

    Map<String, dynamic> customerMap = {
      'jobnumber': _currentjobnumber!,
      'status': 'Pending',
      'type': type,
      'customer': customerName,
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

    // Use the callCollection.doc().collection(customerName) path instead of collection(customerName)
    await callCollection.doc(_currentjobnumber).set(customerMap);

    await getServiceDataFromFirebase();
    controllerClear(false);
    notifyListeners();
  }

  // textformfieldValidation(String value, int index) {
  //   if (index == 0) {
  //     if (value.isEmpty) {
  //       validationError[index] = 'This value is required';
  //     } else if (!collectionOfDatas.containsKey(value)) {
  //       validationError[index] = 'Unown Customer';
  //     } else {
  //       validationError[index] = '';
  //     }
  //     notifyListeners();
  //   } else {
  //     if (value.isEmpty) {
  //       validationError[index] = 'This value is required';
  //     } else {
  //       validationError[index] = '';
  //     }
  //     notifyListeners();
  //   }
  // }

  bool alltextformfieldValidation() {
    if (customer.text.isEmpty) {
      validationError = "Customer field is required";
    } else if (!collectionOfDatas.containsKey(customer.text)) {
      validationError = 'This Customer not valied';
    } else if (productCategory.text.isEmpty) {
      validationError = "ProductCategory field is required";
    } else if (product.text.isEmpty) {
      validationError = "Product field is required";
    } else if (complaint.text.isEmpty) {
      validationError = "Complaint field is required";
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

  controllerClear(bool isCustomerClear) {
    if (isCustomerClear) {
      customer.text = '';
    }

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
