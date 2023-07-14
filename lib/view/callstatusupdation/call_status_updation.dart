import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';
import 'package:service_manager/core/sizing.dart';
import 'package:service_manager/view/widget/textformfield_rightside_text.dart';
import '../../controller/provider/date_picker_provider/date_picker_provider.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/colors.dart';
import '../../core/naming.dart';
import '../widget/dropdown_button_widget/dropdown_button_widget.dart';
import '../widget/textformfiewld.dart';

class ScreenCallStatusUpdation extends StatelessWidget {
  ScreenCallStatusUpdation(
      {super.key, required this.docId, required this.customerName});
  String docId;
  String customerName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ServiceCallStatusUpdationNotifier>(
          builder: (context, serviceCallStatusUpdationNotifier, child) {
            return ListView(
              padding: const EdgeInsets.only(
                top: 10,
                left: 17,
              ),
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: KColors.clrDarkBlue,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Text(
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DropdownButtonWidget(
                        list: const ['Pending', 'Estimate', 'Complete',],
                        status: serviceCallStatusUpdationNotifier.status!,
                        width: 100,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Customer',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: 370,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: KColors.clrGrey),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  customerName,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TopTextTextFormFieldWidget(
                            height: 40,
                            width: 180,
                            text: 'Product Category',
                            controllerIndex: 2,
                            fontsize: 17,
                            screenName: allScreenNames[3],
                            controllerObj: serviceCallStatusUpdationNotifier
                                .productCategory),
                        Text(
                          serviceCallStatusUpdationNotifier.validationError[1],
                          style:
                              const TextStyle(color: Colors.red, fontSize: 11),
                        ),
                        kWidth10,
                        Consumer<DatePickerNotifier>(
                            builder: (context, datePickerNotifier, child) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      datePickerNotifier.datePicker(context);
                                    },
                                    child: Container(
                                      width: 180,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(color: KColors.clrGrey),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              datePickerNotifier.formattedDate!,
                                              style: const TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        }),
                      ],
                    ),
                    TopTextTextFormFieldWidget(
                      height: 50,
                      width: 370,
                      text: 'Product',
                      screenName: allScreenNames[3],
                      controllerIndex: 4,
                      controllerObj: serviceCallStatusUpdationNotifier.product,
                    ),
                    Text(
                      serviceCallStatusUpdationNotifier.validationError[3],
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                    TopTextTextFormFieldWidget(
                      height: 50,
                      width: 370,
                      text: 'Service',
                      screenName: allScreenNames[3],
                      controllerIndex: 5,
                      controllerObj: serviceCallStatusUpdationNotifier.service,
                    ),
                    Text(
                      serviceCallStatusUpdationNotifier.validationError[4],
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                    TopTextTextFormFieldWidget(
                      height: 200,
                      width: 370,
                      text: 'Description',
                      condition: true,
                      screenName: allScreenNames[3],
                      controllerIndex: 6,
                      controllerObj:
                          serviceCallStatusUpdationNotifier.description,
                    ),
                    Text(
                      serviceCallStatusUpdationNotifier.validationError[5],
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                    Row(
                      children: [
                        RightTextTextFormFieldWidget(
                          width: 150,
                          height: 50,
                          text: 'Amount',
                          keyboardType: TextInputType.number,
                          controllerObj:
                              serviceCallStatusUpdationNotifier.amount,
                          fontsize: 20,
                        ),
                        Text(
                          serviceCallStatusUpdationNotifier.validationError[6],
                          style:
                              const TextStyle(color: Colors.red, fontSize: 11),
                        ),
                      ],
                    ),
                    kHeight20,
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
                                condition = Provider.of<
                                            ServiceCallStatusUpdationNotifier>(
                                        context,
                                        listen: false)
                                    .alltextformfieldValidation();
                                if (condition) {
                                  loadingModel.startLoading();
                                  await Provider.of<ServiceCallStatusUpdationNotifier>(
                                          context,
                                          listen: false)
                                      .serviceCallStatusUpdation(
                                          currentStatus: dropdownValue!,
                                          customer:
                                              serviceCallStatusUpdationNotifier
                                                  .customer.text,
                                          productCategory:
                                              serviceCallStatusUpdationNotifier
                                                  .productCategory.text,
                                          updatedDate:
                                              serviceCallStatusUpdationNotifier
                                                  .updatedDate.text,
                                          product: serviceCallStatusUpdationNotifier
                                              .product.text,
                                          service:
                                              serviceCallStatusUpdationNotifier
                                                  .service.text,
                                          decoration:
                                              serviceCallStatusUpdationNotifier
                                                  .description.text,
                                          amount:
                                              serviceCallStatusUpdationNotifier
                                                  .amount.text,
                                          docId: docId, );
                                  loadingModel.stopLoading();
                                  final snackBar =  SnackBar(
                                    content: const Text('Call Status Updated'),
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
                                  : const Center(
                                      child:Text('Update Status'),
                                    ),
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
          },
        ),
      ),
    );
  }
}
