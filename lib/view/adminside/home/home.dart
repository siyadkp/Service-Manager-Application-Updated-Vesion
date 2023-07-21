import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/view/adminside/addproduct/add_product.dart';
import 'package:service_manager/view/product_view/widget/single_product_view_widget.dart';
import '../../../controller/provider/add_customer_provider/add_customer_provider.dart';
import '../../../controller/provider/login/login_page_provider.dart';
import '../../costomeradding/screen_customer_adding_and_updating.dart';
import '../../customer_view.dart/widget/customer_view_singlewidget.dart';
import '../../login/sign_in.dart';

class ScreenAdminHome extends StatelessWidget {
  const ScreenAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Admin View',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                    ),
                  ),
                  InkWell(
                    child: const CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 25,
                      backgroundImage: AssetImage('asset/user.jpeg'),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) => AlertDialog(
                          title: const Text('Warning'),
                          content: const Text(
                              'Are you sure you want to log out? You will be redirected to the login page.'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Sign out',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () async {
                                Provider.of<SignInNotifier>(context,
                                        listen: false)
                                    .validationError = ['', '', ''];
                                final FirebaseAuth _auth =
                                    FirebaseAuth.instance;
                                await _auth.signOut();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenSignIn(),
                                  ),
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 250, top: 30),
                child: Column(
                  children: [
                    InkWell(
                      child: Image.asset(
                        'asset/add.png',
                        height: 70,
                      ),
                      onTap: () {
                        Provider.of<AdminAddProductNotifier>(context,
                                listen: false)
                            .validationError = "";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ScreenAdminAddProduct(pageFinder: 1),
                          ),
                        );
                      },
                    ),
                    const Text(
                      'Add Product',
                      style: TextStyle(fontSize: 19),
                    )
                  ],
                ),
              ),
              const Expanded(
                child: AdminHomeScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminAddProductNotifier>(
      builder: (context, adminAddProductNotifier, _) =>
          adminAddProductNotifier.productDatas.isEmpty
              ? const Center(
                  child: Text(
                    'No listed products',
                    style: TextStyle(fontSize: 17),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          adminAddProductNotifier
                              .productDataLoadingForEditingScreen(
                                  adminAddProductNotifier.productDatas[
                                      adminAddProductNotifier
                                          .productsKeys[index]]!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenAdminAddProduct(
                                    pageFinder: 2,
                                    productkey: adminAddProductNotifier
                                        .productDatas[adminAddProductNotifier
                                            .productsKeys[index]]!
                                        .id),
                              ));
                        },
                        child: SingleProductViewWidget(
                            productData: adminAddProductNotifier.productDatas[
                                adminAddProductNotifier
                                    .productsKeys[index]]));
                  },
                  itemCount: adminAddProductNotifier.productDatas.length,
                ),
    );
  }
}

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs

      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(
                text: 'Product View',
              ),
              Tab(text: 'Customer View'),
            ],
            indicatorColor: KColors.clrDarkBlue, // Change the indicator color
            labelColor:
                KColors.clrDarkBlue, // Change the selected tab label color
            unselectedLabelColor: Colors.black,
          ),
          const Expanded(
            child: TabBarView(
              children: [ProductView(), CustomerView()],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCustomerNotifier>(
      builder: (context, addCustomerNotifier, _) {
        return (addCustomerNotifier.customerDatas.isEmpty)
            ? const Center(
                child: Text(
                'No Customers',
                style: TextStyle(fontSize: 17),
              ))
            : ListView.separated(
                padding:
                    const EdgeInsets.only(top: 5, left: 15, right: 15),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      addCustomerNotifier
                          .customerDataLoadingForEditingScreen(
                              addCustomerNotifier.customerDatas[
                                  addCustomerNotifier
                                      .customerKeys[index]]!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScreenCustomerAddingAndUpdating(
                                    appBarText: "Customer Editing",
                                    genderStatus:
                                        addCustomerNotifier.gender,
                                    keyValue: addCustomerNotifier
                                        .customerDatas[addCustomerNotifier
                                            .customerKeys[index]]
                                        ?.id,oldCUstomerName:addCustomerNotifier.firstName.text),
                          ));
                    },
                    child: CustomerViewSingleWidget(
                      customerData: addCustomerNotifier.customerDatas[
                          addCustomerNotifier.customerKeys[index]],width: 350,
                    ),
                  );
                },
                itemCount: addCustomerNotifier.customerDatas.length,
              );
      },
    );
  }
}


