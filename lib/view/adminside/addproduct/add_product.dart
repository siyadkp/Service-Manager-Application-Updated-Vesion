import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/loading/loading.dart';
import 'package:service_manager/view/widget/textformfield_rightside_text.dart';
import '../../../controller/provider/admin_add_product/admin_add_product_provider.dart';
import '../../../core/colors.dart';
import '../../../core/naming.dart';
import '../../../core/sizing.dart';
import '../../widget/textformfiewld.dart';

class ScreenAdminAddProduct extends StatelessWidget {
  ScreenAdminAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: size.height * 1.05,
                  width: size.width / 1.03,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: KColors.clrDarkBlue,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Consumer<AdminAddProductNotifier>(
                            builder: (context, adminAddProductNotifier, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: InkWell(
                                        child: Container(
                                          height: 200,
                                          width: 350,
                                          decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black45)),
                                          child: photo == null
                                              ? const Icon(
                                                  Icons.add_a_photo,
                                                  size: 60,
                                                  color: Colors.white,
                                                )
                                              : Image.file(
                                                  File(photo!.path),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        onTap: () => adminAddProductNotifier
                                            .addImageFromGallery(),
                                      )),
                                  TopTextTextFormFieldWidget(
                                    height: 50,
                                    width: 370,
                                    text: 'Product Name',
                                    fontsize: 18,
                                    screenName: allScreenNames[5],
                                    controllerIndex: 0,
                                    controllerObj:
                                        adminAddProductNotifier.productName,
                                  ),
                                  Text(
                                    adminAddProductNotifier.validationError[0],
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 11),
                                  ),
                                  TopTextTextFormFieldWidget(
                                    height: 50,
                                    width: 370,
                                    text: 'Serial No',
                                    fontsize: 18,
                                    screenName: allScreenNames[5],
                                    controllerObj:
                                        adminAddProductNotifier.serialNumber,
                                    controllerIndex: 1,
                                  ),
                                  Text(
                                    adminAddProductNotifier.validationError[1],
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 11),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TopTextTextFormFieldWidget(
                                              height: 50,
                                              width: 80,
                                              text: 'Qty',
                                              screenName: allScreenNames[5],
                                              controllerObj:
                                                  adminAddProductNotifier.qty,
                                              controllerIndex: 2,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            Text(
                                              adminAddProductNotifier
                                                  .validationError[2],
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TopTextTextFormFieldWidget(
                                            height: 50,
                                            width: 150,
                                            text: 'Wholesale Price',
                                            screenName: allScreenNames[5],
                                            controllerObj:
                                                adminAddProductNotifier
                                                    .wholesalePrice,
                                            controllerIndex: 3,
                                            keyboardType: TextInputType.number,
                                          ),
                                          Text(
                                            adminAddProductNotifier
                                                .validationError[3],
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 100),
                                    child: TopTextTextFormFieldWidget(
                                      height: 50,
                                      width: 180,
                                      text: 'Retail Price ',
                                      fontsize: 20,
                                      screenName: allScreenNames[5],
                                      controllerObj:
                                          adminAddProductNotifier.retailPrice,
                                      controllerIndex: 4,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Text(
                                    adminAddProductNotifier.validationError[4],
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 11),
                                  ),
                                  RightTextTextFormFieldWidget(
                                    height: 50,
                                    width: 180,
                                    text: 'Total Price ',
                                    fontsize: 25,
                                    controllerObj:
                                        adminAddProductNotifier.totalPrice,
                                    keyboardType: TextInputType.number,
                                  ),
                                  kHeight20,
                                  Consumer<LoadingModel>(
                                    builder: (context, loadingModel, child) {
                                      return Center(
                                        child: Container(
                                          width: 120,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  KColors.clrDarkBlue, // Background color
                                            ),
                                            onPressed: () async {
                                              bool condition = false;
                                              condition = Provider.of<
                                                          AdminAddProductNotifier>(
                                                      context,
                                                      listen: false)
                                                  .alltextformfieldValidation();
                                              if (condition) {
                                                loadingModel.startLoading();
                                                await Provider.of<
                                                            AdminAddProductNotifier>(
                                                        context,
                                                        listen: false)
                                                    .addProductToFirebase(
                                                  productName:
                                                      adminAddProductNotifier
                                                          .productName.text,
                                                  serialNumber:
                                                      adminAddProductNotifier
                                                          .serialNumber.text,
                                                  qty: adminAddProductNotifier
                                                      .qty.text,
                                                  wholesalePrice:
                                                      adminAddProductNotifier
                                                          .wholesalePrice.text,
                                                  retailPrice:
                                                      adminAddProductNotifier
                                                          .retailPrice.text,
                                                  totalPrice:
                                                      adminAddProductNotifier
                                                          .totalPrice.text,
                                                );
                                                loadingModel.stopLoading();
                                                final snackBar = SnackBar(
                                                  content:
                                                      Text('Product Added'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                  backgroundColor: KColors.clrGreen,
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            },
                                            child: loadingModel.isLoading
                                                ? Center(
                                                    child: SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
                                                                strokeWidth:
                                                                    3)))
                                                : Center(
                                                    child: Text('Add Product')),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
