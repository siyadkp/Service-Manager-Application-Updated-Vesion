import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';
import 'package:service_manager/core/sizing.dart';
import 'package:service_manager/view/service_calls/service_call.dart';
import 'package:service_manager/view/widget/textformfield_rightside_text.dart';
import '../../controller/provider/date_picker_provider/date_picker_provider.dart';
import '../../controller/provider/loading/loading.dart';
import '../../core/colors.dart';
import '../../core/cosnt_values.dart';
import '../../core/naming.dart';
import '../../core/text.dart';
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
      body: Consumer<ServiceCallStatusUpdationNotifier>(
        builder: (context, serviceCallStatusUpdationNotifier, _) {
          return ListView(
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  AppBarWidget(text: "Call Status Updation"),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 285,
                      top: 110,
                    ),
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
                          list: const [
                            'Pending',
                            'Estimate',
                            'Complete',
                          ],
                          status: serviceCallStatusUpdationNotifier.status!,
                          width: 100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        width: 350,
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
                  const SizedBox(
                    height: 20,
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
                        controllerObj:
                            serviceCallStatusUpdationNotifier.productCategory,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Consumer<DatePickerNotifier>(
                        builder: (context, datePickerNotifier, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsets.only(bottom: 7, left: 5, top: 4),
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
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  TopTextTextFormFieldWidget(
                    height: 50,
                    width: 350,
                    text: 'Product',
                    screenName: allScreenNames[3],
                    controllerIndex: 4,
                    controllerObj: serviceCallStatusUpdationNotifier.product,
                  ),
                  TopTextTextFormFieldWidget(
                    height: 50,
                    width: 350,
                    text: 'Service',
                    screenName: allScreenNames[3],
                    controllerIndex: 5,
                    controllerObj: serviceCallStatusUpdationNotifier.service,
                  ),
                  TopTextTextFormFieldWidget(
                    height: 200,
                    width: 350,
                    text: 'Description',
                    condition: true,
                    screenName: allScreenNames[3],
                    controllerIndex: 6,
                    controllerObj:
                        serviceCallStatusUpdationNotifier.description,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      RightTextTextFormFieldWidget(
                        width: 150,
                        height: 50,
                        text: 'Amount  ',
                        keyboardType: TextInputType.number,
                        controllerObj: serviceCallStatusUpdationNotifier.amount,
                        fontsize: 20,
                      ),
                    ],
                  ),
                  kHeight20,
                  ErrorTextWidget(
                      errorText:
                          serviceCallStatusUpdationNotifier.validationError),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<LoadingModel>(
                    builder: (context, loadingModel, _) {
                      return Center(
                        child: SizedBox(
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
                                await Provider.of<
                                            ServiceCallStatusUpdationNotifier>(
                                        context,
                                        listen: false)
                                    .serviceCallStatusUpdation(
                                  currentStatus: dropdownValue!,
                                  customer: serviceCallStatusUpdationNotifier
                                      .customer.text,
                                  productCategory:
                                      serviceCallStatusUpdationNotifier
                                          .productCategory.text,
                                  updatedDate: serviceCallStatusUpdationNotifier
                                      .updatedDate.text,
                                  product: serviceCallStatusUpdationNotifier
                                      .product.text,
                                  service: serviceCallStatusUpdationNotifier
                                      .service.text,
                                  decoration: serviceCallStatusUpdationNotifier
                                      .description.text,
                                  amount: serviceCallStatusUpdationNotifier
                                      .amount.text,
                                  docId: docId,
                                );
                                loadingModel.stopLoading();
                                final snackBar = SnackBar(
                                  content: const Text('Call Status Updated'),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: KColors.clrGreen,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenServiceCalls()));
                              }
                            },
                            child: loadingModel.isLoading
                                ? const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 3),
                                    ),
                                  )
                                : const Center(
                                    child: Text('Update Status'),
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
    );
  }
}
