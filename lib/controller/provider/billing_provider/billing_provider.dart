import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../../model/prouct_model.dart/product_model.dart';
import '../../../view/billing/widget/service_call_showing_widget.dart';

class BillingNotifier with ChangeNotifier {
  TextEditingController customer = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController billingAddress = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  String validationError = '';
  Map<String, QueryDocumentSnapshot<Object?>> singleCustomerCompletedCalls = {};
  List<String> singleCustomerCompletedCallsKeys = [];

  validation(BuildContext context) {
    Map<String, BillProductModel> customerBillData =
        Provider.of<AddProductToBillNotif>(context, listen: false)
            .customerBillData;
    if (customer.text.isEmpty) {
      validationError = 'Customer field is required';
    } else if (phone.text.isEmpty) {
      validationError = 'Phone field is required';
    } else if (billingAddress.text.isEmpty) {
      validationError = 'BillingAddress field is required';
    } else if (customerBillData.isEmpty) {
      validationError = 'You add any item for billing';
    } else if (totalAmount.text.isEmpty) {
      validationError = 'TotalAmount field is required';
    } else {
      validationError = "";
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  clearDataFromController(BuildContext context) async {
    AddProductToBillNotif addProductToBillNotifObj= Provider.of<AddProductToBillNotif>(context,listen: false);
    singleCustomerCompletedCalls ={};
    singleCustomerCompletedCallsKeys =[];
    validationError = '';
    customer.text = '';
    phone.text = '';
    billingAddress.text = '';
    totalAmount.text = '';
    addProductSingleWidgetBuilderObj.clear();
     addProductToBillNotifObj.customerBillData={};
      addProductToBillNotifObj.customerBillDataKeys=[];
    await Provider.of<AddNewServiceCallNotifier>(context, listen: false)
        .getServiceDataFromFirebase();
    notifyListeners();
  }

  totalBillAmountCalculater(BuildContext context) {
    AddProductToBillNotif addProductToBillNotifObj =
        Provider.of<AddProductToBillNotif>(context, listen: false);
    int intToatalAmount = 0;
    if (totalAmount.text != "") {
      intToatalAmount = int.parse(totalAmount.text);
    }

    addProductToBillNotifObj.customerBillData.forEach((key, value) {
      int intSingleProductToatalAmount = int.parse(value.totalAmount);
      intToatalAmount = intToatalAmount + intSingleProductToatalAmount;
      totalAmount.text = intToatalAmount.toString();
    });
  }

  cusomerDataLoading(String key, BuildContext context) {
    AddCustomerNotifier addCustomerNotifierObj =
        Provider.of<AddCustomerNotifier>(context, listen: false);
    AddNewServiceCallNotifier addNewServiceCallNotifier =
        Provider.of<AddNewServiceCallNotifier>(context, listen: false);
    singleCustomerCompletedCalls = {};
    singleCustomerCompletedCallsKeys = [];
    phone.text = addCustomerNotifierObj.customerDatas[key]?.get('phone');
    billingAddress.text =
        addCustomerNotifierObj.customerDatas[key]?.get('billingAddress') == ""
            ? addCustomerNotifierObj.customerDatas[key]?.get('address')
            : addCustomerNotifierObj.customerDatas[key]?.get('billingAddress');

    if (addNewServiceCallNotifier.userBasedCallDatas.containsKey(key)) {
      singleCustomerCompletedCalls =
          addNewServiceCallNotifier.userBasedCallDatas[key]!;
      singleCustomerCompletedCallsKeys
          .addAll(singleCustomerCompletedCalls.keys);
    }

    notifyListeners();
  }
}
