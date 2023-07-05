import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/view/Login/sign_in.dart';
import 'package:service_manager/view/adminside/home/home.dart';
import 'package:service_manager/view/home/home.dart';
import 'package:service_manager/view/service_calls/widget/service_callview_singlewidget.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState(){
    super.initState();
    navigation(context);
  }

  
  @override
  Widget build(BuildContext context) {


    return const Scaffold();
  }
    navigation(context)async{
     final FirebaseAuth _auth = FirebaseAuth.instance;
await Provider.of<AdminAddProductNotifier>(context,listen: false).getProductDataFormFirebase();
await Provider.of<AddCustomerNotifier>(context,listen: false).getCustomerDataFormFirebase();
await Provider.of<AddNewServiceCallNotifier>(context,listen: false).getServiceDataFormFirebase();
 User? user = _auth.currentUser;
Navigator.push(context, MaterialPageRoute(builder: (context) {
  if(user?.email=='admin123@gmail.com'){
    return const ScreenAdminHome();
  }
   else if(user == null) {
      return ScreenSignIn();
    } else {
      return const ScreenHome();
    }
},),);
  }
}