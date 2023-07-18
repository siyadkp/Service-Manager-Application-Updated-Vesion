import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/core/cosnt_values.dart';
import 'package:service_manager/core/sizing.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/colors.dart';
import '../../core/naming.dart';
import '../../core/text.dart';
import '../widget/dropdown_button_widget/dropdown_button_widget.dart';
import '../widget/textformfiewld.dart';

class ScreenCustomerAdding extends StatefulWidget {
  const ScreenCustomerAdding({super.key});

  @override
  State<ScreenCustomerAdding> createState() => _ScreenCustomerAddingState();
}

class _ScreenCustomerAddingState extends State<ScreenCustomerAdding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Consumer<AddCustomerNotifier>(
              builder: (context, addCustomerNotifier, _) {
            return SafeArea(
              child: Column(
                children: [
                  AppBarWidget(text: 'Customer Adding'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: DropdownButtonWidget(list: [
                          'Mr',
                          'Mrs',
                        ], status: 'Mr', height: 50, width: 50),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15, left: 5),
                      //   child: InkWell(
                      //     onTap: () {  setState(() {
                      //       f();
                      //     });   },
                      //     child: Container(
                      //       width: 50,
                      //       height: 60,
                      //       decoration: BoxDecoration(
                      //           color: Colors.amber,
                      //           borderRadius: BorderRadius.circular(15)),
                      //     ),
                      //   ),
                      // ),
                      kWidth10,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopTextTextFormFieldWidget(
                            height: 50,
                            width: 290,
                            paddingtop: 0,
                            text: 'Fist Name',
                            fontsize: 20,
                            screenName: allScreenNames[1],
                            controllerIndex: 0,
                            controllerObj: addCustomerNotifier.firstName,
                          ),
                        ],
                      ),
                    ],
                  ),
                  TopTextTextFormFieldWidget(
                      height: 50,
                      width: 350,
                      text: 'Last Name',
                      fontsize: 17,
                      screenName: allScreenNames[1],
                      controllerIndex: 1,
                      controllerObj: addCustomerNotifier.lastName),
                  TopTextTextFormFieldWidget(
                      height: 50,
                      width: 350,
                      text: 'Phone',
                      screenName: allScreenNames[1],
                      controllerIndex: 2,
                      keyboardType: TextInputType.phone,
                      controllerObj: addCustomerNotifier.phone),
                  TopTextTextFormFieldWidget(
                      height: 50,
                      width: 350,
                      text: 'Phone 1',
                      keyboardType: TextInputType.phone,
                      screenName: allScreenNames[1],
                      controllerObj: addCustomerNotifier.phone1),
                  TopTextTextFormFieldWidget(
                      height: 50,
                      width: 350,
                      text: 'Place',
                      screenName: allScreenNames[1],
                      controllerIndex: 3,
                      controllerObj: addCustomerNotifier.place),
                  TopTextTextFormFieldWidget(
                      height: 200,
                      width: 350,
                      text: 'Address :',
                      maxLines: 7,
                      screenName: allScreenNames[1],
                      controllerIndex: 4,
                      condition: true,
                      controllerObj: addCustomerNotifier.address),
                  TopTextTextFormFieldWidget(
                      height: 200,
                      width: 350,
                      text: 'Billing Address :',
                      maxLines: 7,
                      screenName: allScreenNames[1],
                      condition: true,
                      controllerObj: addCustomerNotifier.billingAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  ErrorTextWidget(
                    errorText: addCustomerNotifier.validationError,
                  ),
                  Consumer<LoadingModel>(
                    builder: (context, loadingModel, child) {
                      return Center(
                        child: Container(
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  KColors.clrDarkBlue, // Background color
                            ),
                            onPressed: () async {
                              bool condition = false;
                              condition = Provider.of<AddCustomerNotifier>(
                                      context,
                                      listen: false)
                                  .alltextformfieldValidation();
                              if (condition) {
                                loadingModel.startLoading();
                                await Provider.of<AddCustomerNotifier>(context,
                                        listen: false)
                                    .addCustomerToFirebase(
                                  gender: dropdownValue ?? '',
                                  firstName: addCustomerNotifier.firstName.text,
                                  lastName: addCustomerNotifier.lastName.text,
                                  phone: addCustomerNotifier.phone.text,
                                  phone1: addCustomerNotifier.phone1.text,
                                  place: addCustomerNotifier.place.text,
                                  address: addCustomerNotifier.address.text,
                                  billingAddress:
                                      addCustomerNotifier.billingAddress.text,
                                );
                                loadingModel.stopLoading();
                                final snackBar = SnackBar(
                                  content: const Text('Cutomor Added'),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: KColors.clrGreen,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: loadingModel.isLoading
                                ? const Center(
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3)))
                                : const Center(child: Text('Add Customer')),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
