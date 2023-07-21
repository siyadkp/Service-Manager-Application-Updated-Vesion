import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/loading/loading.dart';
import 'package:service_manager/core/text.dart';
import 'package:service_manager/view/widget/textformfield_rightside_text.dart';
import '../../../controller/provider/admin_add_product/admin_add_product_provider.dart';
import '../../../core/colors.dart';
import '../../../core/naming.dart';
import '../../../core/sizing.dart';
import '../../widget/textformfiewld.dart';

class ScreenAdminAddProduct extends StatelessWidget {
  ScreenAdminAddProduct({super.key, required this.pageFinder, this.productkey});
  int pageFinder;
  String? productkey;
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
                  height: size.height * 1.03,
                  width: size.width / 1.03,
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 30,
                                color: KColors.clrDarkBlue,
                              ),
                            ),
                          ],
                        ),
                        Consumer<AdminAddProductNotifier>(
                          builder: (context, adminAddProductNotifier, _) {
                            return Column(
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
                                              width: 1, color: Colors.black45),
                                        ),
                                        child: pageFinder == 1
                                            ? photo == null
                                                ? const Icon(
                                                    Icons.add_a_photo,
                                                    size: 60,
                                                    color: Colors.white,
                                                  )
                                                : Image.file(
                                                    File(photo!.path),
                                                    fit: BoxFit.cover,
                                                  )
                                            : currentPhotoPathInString == ""
                                                ? const Icon(
                                                    Icons.add_a_photo,
                                                    size: 60,
                                                    color: Colors.white,
                                                  )
                                                : Image.network(
                                                    currentPhotoPathInString,fit:BoxFit.cover,),
                                      ),
                                      onTap: () {if(pageFinder == 1){ adminAddProductNotifier
                                          .addImageFromGallery(); }
                          })),
                                TopTextTextFormFieldWidget(
                                  height: 50,
                                  width: 350,
                                  text: 'Product Name',
                                  fontsize: 18,
                                  screenName: allScreenNames[5],
                                  controllerIndex: 0,
                                  controllerObj:
                                      adminAddProductNotifier.productName,
                                ),
                                TopTextTextFormFieldWidget(
                                  height: 50,
                                  width: 350,
                                  text: 'Serial No',
                                  fontsize: 18,
                                  screenName: allScreenNames[5],
                                  controllerObj:
                                      adminAddProductNotifier.serialNumber,
                                  controllerIndex: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30),
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
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        TopTextTextFormFieldWidget(
                                          height: 50,
                                          width: 150,
                                          text: 'Wholesale Price',
                                          screenName: allScreenNames[5],
                                          controllerObj: adminAddProductNotifier
                                              .wholesalePrice,
                                          controllerIndex: 3,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    TopTextTextFormFieldWidget(
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
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
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
                                  ],
                                ),
                                kHeight20,
                                ErrorTextWidget(
                                    errorText: adminAddProductNotifier
                                        .validationError),
                                Consumer<LoadingModel>(
                                  builder: (context, loadingModel, _) {
                                    return Center(
                                      child: SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: KColors
                                                .clrDarkBlue, // Background color
                                          ),
                                          onPressed: () async {
                                            bool condition = false;
                                            condition = adminAddProductNotifier
                                                .alltextformfieldValidation();
                                            if (condition && pageFinder == 1) {
                                              loadingModel.startLoading();

                                              await adminAddProductNotifier
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
                                                content: const Text(
                                                    'Product is Added'),
                                                duration:
                                                    const Duration(seconds: 3),
                                                backgroundColor:
                                                    KColors.clrGreen,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else if (condition &&
                                                pageFinder == 2) {
                                              loadingModel.startLoading();
                                             await  adminAddProductNotifier
                                                  .updateProductData(
                                                key: productkey!,
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
                                                content: const Text(
                                                    'Product is updated'),
                                                duration:
                                                    const Duration(seconds: 3),
                                                backgroundColor:
                                                    KColors.clrGreen,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: loadingModel.isLoading
                                              ? const Center(
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 3),
                                                  ),
                                                )
                                              :  Center(
                                                  child: pageFinder ==1 ? const Text('Add Product'):const Text('Product Updated')),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
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
