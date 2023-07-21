import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/core/cosnt_values.dart';
import 'package:service_manager/core/sizing.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/colors.dart';
import '../../core/naming.dart';
import '../../core/text.dart';
import '../widget/dropdown_button_widget/dropdown_button_widget.dart';
import '../widget/textformfiewld.dart';

class ScreenCustomerAddingAndUpdating extends StatelessWidget {
  ScreenCustomerAddingAndUpdating(
      {super.key,
      required this.appBarText,
      required this.genderStatus,
      required this.oldCUstomerName,
      this.keyValue});
  String appBarText;
  String genderStatus;
  String oldCUstomerName;
  String? keyValue;
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
                    AppBarWidget(text: appBarText),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: DropdownButtonWidget(list: const [
                            'Mr',
                            'Mrs',
                          ], status: genderStatus, height: 50, width: 50),
                        ),
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
                          child: SizedBox(
                            width: 170,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      KColors.clrDarkBlue, // Background color
                                ),
                                onPressed: () async {
                                  bool condition = false;
                                  condition = addCustomerNotifier
                                      .alltextformfieldValidation();
                                  if (condition &&
                                      appBarText == "Customer Adding") {
                                    loadingModel.startLoading();
                                    await addCustomerNotifier
                                        .addCustomerToFirebase(
                                      gender: dropdownValue ?? '',
                                      firstName:
                                          addCustomerNotifier.firstName.text,
                                      lastName:
                                          addCustomerNotifier.lastName.text,
                                      phone: addCustomerNotifier.phone.text,
                                      phone1: addCustomerNotifier.phone1.text,
                                      place: addCustomerNotifier.place.text,
                                      address: addCustomerNotifier.address.text,
                                      billingAddress: addCustomerNotifier
                                          .billingAddress.text,
                                    );
                                    loadingModel.stopLoading();
                                    final snackBar = SnackBar(
                                      content: const Text('Customer Added'),
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: KColors.clrGreen,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (condition) {
                                    loadingModel.startLoading();
                                    await addCustomerNotifier
                                        .updateCustomerData(
                                            key: keyValue!,
                                            gender: addCustomerNotifier.gender,
                                            firstName: addCustomerNotifier
                                                .firstName.text,
                                            lastName: addCustomerNotifier
                                                .lastName.text,
                                            phone:
                                                addCustomerNotifier.phone.text,
                                            phone1:
                                                addCustomerNotifier.phone1.text,
                                            place:
                                                addCustomerNotifier.place.text,
                                            address: addCustomerNotifier
                                                .address.text,
                                            billingAddress: addCustomerNotifier
                                                .billingAddress.text);
                                     Provider.of<
                                                AddNewServiceCallNotifier>(
                                            context,
                                            listen: false)
                                        .serviceCallCustomerUpdating(
                                            oldCUstomerName,
                                            addCustomerNotifier.firstName.text);
                                    loadingModel.stopLoading();
                                    final snackBar = SnackBar(
                                      content: const Text('Customer Updated'),
                                      duration: const Duration(seconds: 3),
                                      backgroundColor: KColors.clrGreen,
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
                                            child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3),),)
                                    : appBarText == "Customer Adding"
                                        ? const Center(child: Text('Add Customer'),)
                                        : const Center(
                                            child: Text('Update Customer'),),),
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
            },
          )
        ],
      ),
    );
  }
}
