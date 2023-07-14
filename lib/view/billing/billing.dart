import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/billing_provider/billing_provider.dart';
import 'package:service_manager/model/prouct_model.dart/product_model.dart';
import 'package:service_manager/view/billing/addbillproduct/add_product_to_bill.dart';
import 'package:service_manager/view/widget/dropdown_textformfield/dropdown_textformfield.dart';
import '../../controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../controller/provider/pdf_generator.dart/pdf_generator.dart';
import '../../core/colors.dart';
import '../../core/naming.dart';
import '../../core/sizing.dart';
import '../widget/textformfield_rightside_text.dart';
import '../widget/textformfiewld.dart';
import 'addbillproduct/widget/add_single_product_widget.dart';
import 'addbillproduct/widget/customer_call_widget.dart';

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
        padding: const EdgeInsets.only(top: 10),
        child: Consumer<BillingNotifier>(
          builder: (context, billingNotifier, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 350),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownTextFormField(
                        screenName: allScreenNames[9],
                        suggetion: Provider.of<AddCustomerNotifier>(context,
                                listen: false)
                            .customerKeys),
                    Text(
                      billingNotifier.validationError,
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ],
                ),

                //  TopTextTextFormFieldWidget(height: 50,width: 370,text: 'Customer',fontsize: 20, controllerObj: TextEditingController(),screenName: ''),
                TopTextTextFormFieldWidget(
                    height: 50,
                    width: 370,
                    text: 'Phone',
                    controllerObj: billingNotifier.phone,
                    screenName: ''),
                TopTextTextFormFieldWidget(
                    height: 200,
                    width: 370,
                    text: 'Billing Address :',
                    maxLines: 7,
                    condition: true,
                    controllerObj: billingNotifier.billingAddress,
                    screenName: ''),
                SizedBox(
                  height: 200,
                  width: 400,
                  child: ListView.builder(
                    itemBuilder: (context, index) => CustomerCallWidget(
                      callData: billingNotifier.singleCustomerCompletedCalls[
                          billingNotifier
                              .singleCustomerCompletedCallsKeys[index]],
                    ),
                    itemCount:
                        billingNotifier.singleCustomerCompletedCalls.length,
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add Items',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenAddBillToProduct(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const Divider(color: Colors.grey, thickness: 3),
                      SizedBox(
                        width: double.infinity,
                        height: 220,
                        child: Consumer<AddProductToBillNotif>(
                            builder: (context, addProductToBillNotif, _) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return AddProductSingleWidget(
                                  billProductData:
                                      addProductToBillNotif.customerBillData[
                                          addProductToBillNotif
                                              .customerBillDataKeys[index]]);
                            },
                            itemCount:
                                addProductToBillNotif.customerBillData.length,
                          );
                        }),
                      ),
                      const Divider(color: Colors.grey, thickness: 3),
                    ],
                  ),
                ),

                RightTextTextFormFieldWidget(
                    width: 100,
                    height: 50,
                    text: 'Total Amount',
                    controllerObj: billingNotifier.totalAmount,
                    fontsize: 20),

                ElevatedButton(
                  onPressed: () {
                    pdfGeneratorObj.generateInvoicePDF(
                        context,
                        addProductToBillNotifObj.customerBillData,
                        addProductToBillNotifObj.totalAmount.text,
                        addProductToBillNotifObj.discount.text);
                    addProductToBillNotifObj.controllerDataClearing();
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
    ),);
  }
}
