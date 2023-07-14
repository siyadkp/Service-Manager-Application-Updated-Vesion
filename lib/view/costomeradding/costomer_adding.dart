import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/core/sizing.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/colors.dart';
import '../../core/naming.dart';
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
        padding: const EdgeInsets.only(top: 30, left: 13),
        children: [
          Consumer<AddCustomerNotifier>(
              builder: (context, addCustomerNotifier, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){ Navigator.pop(context);}, icon:Icon(Icons.arrow_back,color:KColors.clrDarkBlue,),),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: DropdownButtonWidget(list: ['Mr','Mrs',],status: 'Mr',),
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
                          height: 54,
                          width: 300,
                          paddingtop: 0,
                          text: 'Fist Name',
                          fontsize: 20,
                          screenName: allScreenNames[1],
                          controllerIndex: 0,
                          controllerObj: addCustomerNotifier.firstName,
                        ),
                        Text(
                          addCustomerNotifier.validationError[0],
                          style:
                              const TextStyle(color: Colors.red, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
                TopTextTextFormFieldWidget(
                    height: 60,
                    width: 370,
                    text: 'Last Name',
                    fontsize: 17,
                    screenName: allScreenNames[1],
                    controllerIndex: 1,
                    controllerObj: addCustomerNotifier.lastName),
                Text(
                  addCustomerNotifier.validationError[1],
                  style: const TextStyle(color: Colors.red, fontSize: 11),
                ),
                TopTextTextFormFieldWidget(
                    height: 50,
                    width: 370,
                    text: 'Phone',
                    screenName: allScreenNames[1],
                    controllerIndex: 2,
                    keyboardType: TextInputType.phone,
                    controllerObj: addCustomerNotifier.phone),
                Text(
                  addCustomerNotifier.validationError[2],
                  style: const TextStyle(color: Colors.red, fontSize: 11),
                ),
                TopTextTextFormFieldWidget(
                    height: 50,
                    width: 370,
                    text: 'Phone 1',
                     keyboardType: TextInputType.phone,
                    screenName: allScreenNames[1],
                    controllerObj: addCustomerNotifier.phone1),
                TopTextTextFormFieldWidget(
                    height: 50,
                    width: 370,
                    text: 'Place',
                    screenName: allScreenNames[1],
                    controllerIndex: 3,
                    controllerObj: addCustomerNotifier.place),
                Text(
                  addCustomerNotifier.validationError[3],
                  style: const TextStyle(color: Colors.red, fontSize: 11),
                ),
                TopTextTextFormFieldWidget(
                    height: 200,
                    width: 370,
                    text: 'Address :',
                    maxLines: 7,
                    screenName: allScreenNames[1],
                    controllerIndex: 4,
                    condition: true,
                    controllerObj: addCustomerNotifier.address),
                Text(
                  addCustomerNotifier.validationError[4],
                  style: const TextStyle(color: Colors.red, fontSize: 11),
                ),
                TopTextTextFormFieldWidget(
                    height: 200,
                    width: 370,
                    text: 'Billing Address :',
                    maxLines: 7,
                    screenName: allScreenNames[1],
                    condition: true,
                    controllerObj: addCustomerNotifier.billingAddress),
                Consumer<LoadingModel>(
                  builder: (context, loadingModel, child) {
                    return Center(
                      child: Container(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KColors.clrDarkBlue, // Background color
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
                                gender: dropdownValue??'',
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
                                content: Text('Cutomor Added'),
                                duration: Duration(seconds: 3),
                                backgroundColor:KColors.clrGreen,
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
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 3)))
                              : Center(child: Text('Add Product')),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}

