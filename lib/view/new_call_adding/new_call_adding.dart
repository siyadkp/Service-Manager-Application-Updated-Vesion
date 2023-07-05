
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/date_picker_provider/date_picker_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/sizing.dart';
import 'package:service_manager/view/widget/dropdown_button_widget/dropdown_button_widget.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/naming.dart';
import '../widget/dropdown_textformfield/dropdown_textformfield.dart';
import '../widget/textformfiewld.dart';


class ScreenAddNewCall extends StatefulWidget {
  const ScreenAddNewCall({super.key});

  @override
  State<ScreenAddNewCall> createState() => _ScreenAddNewCallState();
}

class _ScreenAddNewCallState extends State<ScreenAddNewCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AddNewServiceCallNotifier>(
            builder: (context, addNewCallNotifier, child) {
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, left: 17),
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: () {
                        FocusScope.of(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        color: clrDarkBlue,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        DropdownButtonWidget(
                            list: ['Carry In', 'On Site'],
                            status: 'Carry In',
                            width: 80),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownTextFormField(
                    suggestions:
                        Provider.of<AddCustomerNotifier>(context, listen: false)
                            .customerKeys,
                  ),
                  Text(
                    addNewCallNotifier.validationError[0],
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopTextTextFormFieldWidget(
                            height: 40,
                            width: 180,
                            text: 'Product Category',
                            screenName: allScreenNames[2],
                            controllerIndex: 1,
                            fontsize: 17,
                            controllerObj: addNewCallNotifier.productCategory,
                          ),
                          Text(
                            addNewCallNotifier.validationError[1],
                            style: const TextStyle(
                                color: Colors.red, fontSize: 11),
                          ),
                        ],
                      ),
                      kWidth10,
                      Consumer<DatePickerNotifier>(
                          builder: (context, datePickerNotifier, child) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              InkWell(
                                onTap: () {
                                  datePickerNotifier.datePicker(context);
                                },
                                child: Container(
                                  width: 180,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(color: clrGrey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          datePickerNotifier.formattedDate!,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]);
                      }),
                      
                    ],
                  ),
                  TopTextTextFormFieldWidget(
                    height: 50,
                    width: 370,
                    text: 'Product',
                    screenName: allScreenNames[2],
                    controllerIndex: 3,
                    controllerObj: addNewCallNotifier.product,
                  ),
                  Text(
                    addNewCallNotifier.validationError[3],
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                  TopTextTextFormFieldWidget(
                    height: 50,
                    width: 370,
                    text: 'Complaint',
                    screenName: allScreenNames[2],
                    controllerIndex: 4,
                    controllerObj: addNewCallNotifier.complaint,
                  ),
                  Text(
                    addNewCallNotifier.validationError[4],
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          TopTextTextFormFieldWidget(
                            height: 50,
                            width: 320,
                            text: 'Serail No',
                            screenName: allScreenNames[2],
                            controllerIndex: 5,
                            controllerObj: addNewCallNotifier.serialNumber,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 15,
                          top: 45,
                        ),
                        child: IconButton(
                            onPressed: () {
                              addNewCallNotifier.scanBarcode();
                            },
                            icon: Icon(Icons.camera_alt_sharp)),
                      )
                    ],
                  ),
                  TopTextTextFormFieldWidget(
                    height: 200,
                    width: 370,
                    text: 'Description :',
                    maxLines: 7,
                    condition: true,
                    screenName: allScreenNames[2],
                    controllerIndex: 6,
                    controllerObj: addNewCallNotifier.description,
                  ),
                  kHeight20,
                  Consumer<LoadingModel>(
                    builder: (context, loadingModel, child) {
                      return Center(
                        child: Container(
                          width: 130,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: clrDarkBlue, // Background color
                            ),
                            onPressed: () async {
                              bool condition = false;
                              condition =
                                  Provider.of<AddNewServiceCallNotifier>(
                                          context,
                                          listen: false)
                                      .alltextformfieldValidation();
                              if (condition) {
                                loadingModel.startLoading();
                                await Provider.of<AddNewServiceCallNotifier>(
                                        context,
                                        listen: false)
                                    .addNewCallToFirebase(
                                        type: dropdownValue!,
                                        productCategory: addNewCallNotifier
                                            .productCategory.text,
                                        date: Provider.of<DatePickerNotifier>(context,listen: false).formattedDate!,
                                        product:
                                            addNewCallNotifier.product.text,
                                        complaint:
                                            addNewCallNotifier.complaint.text,
                                        serialNumber: addNewCallNotifier
                                            .serialNumber.text,
                                        description: addNewCallNotifier
                                            .description.text);
                                loadingModel.stopLoading();
                                final snackBar = SnackBar(
                                  content: Text('New Call Added'),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: clrGreen,
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
                                            color: Colors.white,
                                            strokeWidth: 3)))
                                : Text('Add New Call'),
                          ),
                        ),
                      );
                    },
                  ),
                  kHeight20
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
