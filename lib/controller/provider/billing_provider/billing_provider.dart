import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';

class BillingNotifier with ChangeNotifier{

  TextEditingController customer = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController billingAddress = TextEditingController();
  String validationError='';
  


validation(){
if(customer.text.isEmpty){
validationError='This Value is required';
}else{
  validationError='';
}
notifyListeners();
}

clearDataFromController(){
validationError='';
customer.text='';
phone.text='';
billingAddress.text='';
}

cusomerDataLoading(String key,BuildContext context){
AddCustomerNotifier addCustomerNotifierObj=Provider.of<AddCustomerNotifier>(context,listen: false);
phone.text=addCustomerNotifierObj.customerDatas[key]?.get('phone');
billingAddress.text=addCustomerNotifierObj.customerDatas[key]?.get('billingAddress')!=''?addCustomerNotifierObj.customerDatas[key]?.get('billingAddress'): addCustomerNotifierObj.customerDatas[key]?.get('address');
notifyListeners();
}

}