import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/loading/loading.dart';
import 'package:service_manager/view/widget/textformfield_rightside_text.dart';
import '../../../core/colors.dart';
import '../../../core/naming.dart';
import '../../../core/sizing.dart';
import '../../widget/textformfiewld.dart';
import '../billing.dart';

class ScreenAddBillProduct extends StatelessWidget {
   ScreenAddBillProduct({super.key});
TextEditingController qty =TextEditingController();
TextEditingController discount =TextEditingController();
TextEditingController amount =TextEditingController();
TextEditingController totalAmount =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15,top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           InkWell( onTap: () {
                      Navigator.pop(context);
                    }, child: Container(width: 40,height: 40,color: clrDarkBlue,child: const Icon(Icons.arrow_back,color: Colors.white,size: 30,),)),
          
          TopTextTextFormFieldWidget(
            height: 50,
            width: 370,
            text: 'Product',
            fontsize: 18,screenName: allScreenNames [4],controllerObj: TextEditingController(), controllerIndex: 1
          ),
          Row(
            children: [
              RightTextTextFormFieldWidget(height: 50, width: 80, text: 'Qty',controllerObj: qty),
              kWidth20,
              RightTextTextFormFieldWidget(
                  height: 50, width: 150, text: 'Discount',controllerObj: discount),
            ],
          ),
          RightTextTextFormFieldWidget(
            height: 50,
            width: 180,
            text: 'Amount :',
            fontsize: 20,controllerObj: amount,
          ),
          RightTextTextFormFieldWidget(
            height: 50,
            width: 180,
            text: 'Total Amount :',controllerObj: totalAmount,
            fontsize: 25,
          ),
          kHeight20,
          Center(
            child: Consumer<LoadingModel>(
              builder: (context, value, child)  {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: clrDarkBlue,
                  ),
                  child: const Text('Add To Bill'),
                );
              }
            ),
          ),
        ]),
      ),
    ));
  }
}
