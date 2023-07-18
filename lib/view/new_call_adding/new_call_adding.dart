import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/date_picker_provider/date_picker_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/sizing.dart';
import 'package:service_manager/view/widget/dropdown_button_widget/dropdown_button_widget.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/cosnt_values.dart';
import '../../core/naming.dart';
import '../../core/text.dart';
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
        child:
         Consumer<AddNewServiceCallNotifier>(
            builder: (context, addNewCallNotifier, child) {
          return ListView(
            shrinkWrap: true,
            children: [
              Stack(children: [
                AppBarWidget(text: "Call Registration"),
                Padding(
                  padding: const EdgeInsets.only(left: 310, top: 110),
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
              ]),
              Column(
                children: [
                  DropdownTextFormField(
                    screenName: allScreenNames[2],
                    suggestion:
                        Provider.of<AddCustomerNotifier>(context, listen: false)
                            .customerKeys,
                    text: 'Customer',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopTextTextFormFieldWidget(
                        height: 40,
                        width: 160,
                        text: 'Product Category',
                        screenName: allScreenNames[2],
                        paddingtop: 0,
                        controllerIndex: 1,
                        controllerObj: addNewCallNotifier.productCategory,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Consumer<DatePickerNotifier>(
                          builder: (context, datePickerNotifier, _) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 7, left: 5, top: 4),
                              child: Text(
                                'Date',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                datePickerNotifier.datePicker(context);
                              },
                              child: Container(
                                width: 160,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: KColors.clrGrey),
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
                          ],
                        );
                      }),
                    ],
                  ),
                  TopTextTextFormFieldWidget(
                    height: 50,
                    width: 350,
                    text: 'Product',
                    screenName: allScreenNames[2],
                    controllerIndex: 3,
                    controllerObj: addNewCallNotifier.product,
                  ),
                  TopTextTextFormFieldWidget(
                    height: 50,
                    width: 350,
                    text: 'Complaint',
                    screenName: allScreenNames[2],
                    controllerIndex: 4,
                    controllerObj: addNewCallNotifier.complaint,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopTextTextFormFieldWidget(
                        height: 50,
                        width: 305,
                        text: 'Serail No',
                        screenName: allScreenNames[2],
                        controllerIndex: 5,
                        controllerObj: addNewCallNotifier.serialNumber,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 42,
                          ),
                          IconButton(
                              onPressed: () {
                                addNewCallNotifier.scanBarcode();
                              },
                              icon: Icon(Icons.camera_alt_sharp)),
                        ],
                      )
                    ],
                  ),
                  TopTextTextFormFieldWidget(
                    height: 200,
                    width: 350,
                    text: 'Description :',
                    maxLines: 7,
                    paddingRight: 4,
                    condition: true,
                    screenName: allScreenNames[2],
                    controllerIndex: 6,
                    controllerObj: addNewCallNotifier.description,
                  ),
                  kHeight20,
                  ErrorTextWidget(errorText:addNewCallNotifier.validationError),
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
                                        customerName:
                                            addNewCallNotifier.customer.text,
                                        type: dropdownValue!,
                                        productCategory: addNewCallNotifier
                                            .productCategory.text,
                                        date: Provider.of<DatePickerNotifier>(
                                                context,
                                                listen: false)
                                            .formattedDate!,
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

class BottomCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
