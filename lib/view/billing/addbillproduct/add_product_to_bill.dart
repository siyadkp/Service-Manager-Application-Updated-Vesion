import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/controller/provider/loading/loading.dart';
import 'package:service_manager/model/prouct_model.dart/product_model.dart';
import 'package:service_manager/view/widget/dropdown_textformfield/dropdown_textformfield.dart';
import 'package:service_manager/view/widget/textformfield_rightside_text.dart';
import '../../../core/colors.dart';
import '../../../core/naming.dart';
import '../../../core/sizing.dart';

class ScreenAddBillToProduct extends StatelessWidget {
  const ScreenAddBillToProduct({super.key});

  @override
  Widget build(BuildContext context) {
    AddProductToBillNotif addProductToBillNotifObj =
        Provider.of<AddProductToBillNotif>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Consumer<AddProductToBillNotif>(
          builder: (ctx, addToBillNotif, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
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
                DropdownTextFormField(
                  screenName: allScreenNames[10],
                  suggetion: Provider.of<AdminAddProductNotifier>(context,
                          listen: false)
                      .productsKeys,
                  text: 'Product',
                ),
                Row(
                  children: [
                    RightTextTextFormFieldWidget(
                      height: 50,
                      width: 80,
                      text: 'Qty',
                      controllerObj: addToBillNotif.qty,
                      keyboardType: TextInputType.number,
                    ),
                    kWidth20,
                    RightTextTextFormFieldWidget(
                        height: 50,
                        width: 150,
                        text: 'Discount',
                        keyboardType: TextInputType.number,
                        controllerObj: addToBillNotif.discount),
                  ],
                ),
                RightTextTextFormFieldWidget(
                  height: 50,
                  width: 180,
                  text: 'Amount :',
                  fontsize: 20,
                  keyboardType: TextInputType.number,
                  controllerObj: addToBillNotif.amount,
                ),
                RightTextTextFormFieldWidget(
                  height: 50,
                  width: 180,       
                  text: 'Total Amount :',
                  keyboardType: TextInputType.number,
                  controllerObj: addToBillNotif.totalAmount,
                  fontsize: 25,
                ),
                kHeight20,
                Center(
                  child: Text(
                    addToBillNotif.validationError,
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                ),
                Center(
                  child: Consumer<LoadingModel>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: () {
                          bool condition = false;
                          condition = addToBillNotif.validation();
                          if (condition) {
                            BillProductModel billProductModel =
                                BillProductModel(
                                    productName: addToBillNotif.product.text,
                                    qty: addToBillNotif.qty.text,
                                    discount: addToBillNotif.discount.text,
                                    amount: addToBillNotif.amount.text,
                                    totalAmount:
                                        addToBillNotif.totalAmount.text);
                            addProductToBillNotifObj.addTobill(context,
                                billProductModel, addToBillNotif.product.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KColors.clrDarkBlue,
                        ),
                        child: const Text('Add To Bill'),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
