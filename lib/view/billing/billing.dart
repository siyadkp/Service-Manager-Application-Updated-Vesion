import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/billing_provider/billing_provider.dart';
import 'package:service_manager/core/cosnt_values.dart';
import 'package:service_manager/core/text.dart';
import 'package:service_manager/view/billing/addbillproduct/add_product_to_bill.dart';
import 'package:service_manager/view/billing/widget/service_call_showing_widget.dart';
import 'package:service_manager/view/widget/dropdown_textformfield/dropdown_textformfield.dart';
import '../../controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../controller/provider/pdf_generator.dart/pdf_generator.dart';
import '../../core/colors.dart';
import '../../core/naming.dart';
import '../../core/sizing.dart';
import '../widget/textformfield_rightside_text.dart';
import '../widget/textformfiewld.dart';
import 'addbillproduct/widget/add_single_product_widget.dart';

class ScreenBilling extends StatelessWidget {
  const ScreenBilling({super.key});

  @override
  Widget build(BuildContext context) {
    AddProductToBillNotif addProductToBillNotifObj =
        Provider.of<AddProductToBillNotif>(context, listen: false);
    PdfGenerator pdfGeneratorObj = PdfGenerator();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<BillingNotifier>(
            builder: (context, billingNotifier, _) {
              return Column(
                children: [
                  AppBarWidget(text: 'Billing'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownTextFormField(
                          text: 'Product',
                          screenName: allScreenNames[9],
                          suggestion: Provider.of<AddCustomerNotifier>(context,
                                  listen: false)
                              .customerKeys),
                     
                    ],
                  ),

                  //  TopTextTextFormFieldWidget(height: 50,width: 370,text: 'Customer',fontsize: 20, controllerObj: TextEditingController(),screenName: ''),
                  TopTextTextFormFieldWidget(
                      height: 50,
                      width: 350,
                      text: 'Phone',
                      controllerObj: billingNotifier.phone,
                      screenName: ''),
                  TopTextTextFormFieldWidget(
                      height: 200,
                      width: 350,
                      text: 'Billing Address :',
                      maxLines: 7,
                      condition: true,
                      controllerObj: billingNotifier.billingAddress,
                      screenName: ''),
                  billingNotifier.singleCustomerCompletedCalls.isNotEmpty
                      ? ServiceCallAddingWidget(
                          billingNotifier: billingNotifier,
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Billing Products',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 185,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenAddBillToProduct(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 35,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const Divider(color: Colors.grey, thickness: 1),
                        SizedBox(
                          width: double.infinity,
                          height: 220,
                          child: Consumer<AddProductToBillNotif>(
                              builder: (context, addProductToBillNotif, _) {
                            return addProductToBillNotif
                                    .customerBillData.isEmpty
                                ? Center(
                                    child: Text(
                                    'No listed item',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.black54),
                                  ))
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      return AddProductSingleWidget(
                                          billProductData: addProductToBillNotif
                                                  .customerBillData[
                                              addProductToBillNotif
                                                      .customerBillDataKeys[
                                                  index]]!);
                                    },
                                    itemCount: addProductToBillNotif
                                        .customerBillData.length,
                                  );
                          }),
                        ),
                        const Divider(color: Colors.grey, thickness: 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RightTextTextFormFieldWidget(
                        width: 100,
                        height: 50,
                        text: 'Total Amount  ',
                        controllerObj: billingNotifier.totalAmount,
                        fontsize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ErrorTextWidget(errorText: billingNotifier.validationError),
                  ElevatedButton(
                    onPressed: () {
                   
                      bool condition = false;
                      condition = billingNotifier.validation(context);
                      if (condition) {
                        pdfGeneratorObj.generateInvoicePDF(
                            context,
                            addProductToBillNotifObj.customerBillData,
                            billingNotifier.totalAmount.text,
                            addProductToBillNotifObj.discount.text);
                        addProductToBillNotifObj.controllerDataClearing();
                      }

                      // Provider.of<AddProductToBillNotif>(context, listen: false)
                      //     .generateInvoicePDF(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KColors.clrDarkBlue,
                    ),
                    child: const Text('Create Bill'),
                  ),
                  kHeight20
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
