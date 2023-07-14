import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import '../search/const_search_objects.dart';

class ServiceCallStatusUpdationNotifier with ChangeNotifier {
  ServiceCallStatusUpdationNotifier({required this.context});
  TextEditingController customer = TextEditingController();
  TextEditingController productCategory = TextEditingController();
  TextEditingController updatedDate = TextEditingController();
  TextEditingController product = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController service = TextEditingController();

  BuildContext context;
  String? status;
  CollectionReference callCollection =
      FirebaseFirestore.instance.collection('call_collection');

  bool isWorked = true;
  List<String> validationError = ['', '', '', '', '', '', ''];
  Map<String, QueryDocumentSnapshot> collectionOfDatas =
      customerViewScreenSearchNotifierObject.collectionOfDatas;
  Map<String, QueryDocumentSnapshot> callDatas = {};

//   getServiceDataFormFirebase() async {
//     List<QueryDocumentSnapshot> queryDocumentSnapshot = [];
//     try {
//       queryDocumentSnapshot.clear();
//       callDatas.clear();
//       callDataKeys=[];
//       serviceCallViewScreenSearchNotifierObject.collectionOfDatas = {};
//       serviceCallViewScreenSearchNotifierObject.collectionOfDatsKeys=[];
//      if(isWorked){
//  DocumentReference? jobNumberDoc =  jobNumber.doc("KktKIyTkv43TOmMZjF3i");
//      DocumentSnapshot snapshot = await jobNumberDoc.get();
//      _currentjobnumber=snapshot.get('currentjobnumber');
//      isWorked=false;
//      }
//       QuerySnapshot? customerData = await callCollection.get();
//       queryDocumentSnapshot.addAll(customerData.docs);
//       for (QueryDocumentSnapshot doc in customerData.docs) {
//         callDatas[doc.get('customer')] = doc;
//         serviceCallViewScreenSearchNotifierObject.insert(doc.get('customer'));
//       }
//       serviceCallViewScreenSearchNotifierObject.collectionOfDatas = callDatas;
//       serviceCallViewScreenSearchNotifierObject.collectionOfDatsKeys
//           .addAll(callDatas.keys);
//       callDataKeys.addAll(callDatas.keys);
//     } on FirebaseException catch (e) {
//       print(e);
//     }
//   }

  serviceCallStatusUpdation(
      {required String currentStatus,
      required String customer,
      required String productCategory,
      required String updatedDate,
      required String product,
      required String service,
      required String decoration,
      required String amount,
      required String docId,}) async {

    DocumentReference docRef = callCollection.doc(docId);
    docRef.update({
      'status': currentStatus,
      'customer': customer,
      'productCategory': productCategory,
      'updatedDate': updatedDate,
      'product': product,
      'service': service,
      'decoration': decoration,
      'amount': amount
    });
    Provider.of<AddNewServiceCallNotifier>(context, listen: false)
        .getServiceDataFromFirebase();
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
    if (updatedDate.text.isEmpty) {
      validationError[2] = 'This value is required';
    } else {
      validationError[2] = '';
    }
    if (product.text.isEmpty) {
      validationError[3] = 'This value is required';
    } else {
      validationError[3] = '';
    }
    if (service.text.isEmpty) {
      validationError[4] = 'This value is required';
    } else {
      validationError[4] = '';
    }
    if (description.text.isEmpty) {
      validationError[5] = 'This value is required';
    } else {
      validationError[5] = '';
    }
    if (amount.text.isEmpty) {
      validationError[6] = 'This value is required';
    } else {
      validationError[6] = '';
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
    updatedDate.text = '';
    product.text = '';
    description.text = '';
    service.text = '';
    amount.text = '';
    notifyListeners();
  }

  navigatToUpdateStatusPage(QueryDocumentSnapshot serviceCallData) {
    status = serviceCallData.get('status');
    customer.text = serviceCallData.get('customer');
    productCategory.text = serviceCallData.get('productCategory');
    updatedDate.text = serviceCallData.get('date');
    product.text = serviceCallData.get('product');
    description.text = serviceCallData.get('description');
    service.text = serviceCallData.get('service');
    amount.text = serviceCallData.get('amount');
  }
}
