import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/controller/provider/billing_provider/billing_provider.dart';
import 'package:service_manager/controller/provider/date_picker_provider/date_picker_provider.dart';
import 'package:service_manager/controller/provider/loading/loading.dart';
import 'package:service_manager/controller/provider/login/login_page_provider.dart';
import 'package:service_manager/controller/provider/register/register_page_provider.dart';
import 'package:service_manager/controller/provider/search/search_provider.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';
import 'package:service_manager/view/sample.dart';
import 'package:service_manager/view/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminAddProductNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoadingModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddCustomerNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrieNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddNewServiceCallNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ServiceCallStatusUpdationNotifier(context: context),
        ),
        ChangeNotifierProvider(
          create: (context) => DatePickerNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddProductToBillNotif(),
        ),
        ChangeNotifierProvider(
          create: (context) => BillingNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Service Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.black),
        home: ScreenSplash(),
      ),
    );
  }
}
