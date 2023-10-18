import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/billing_provider/billing_provider.dart';
import 'package:service_manager/view/billing/billing.dart';
import 'package:service_manager/view/new_call_adding/new_call_adding.dart';
import '../../../controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../customer_view.dart/customer_view.dart';
import '../../product_view/product_view.dart';
import '../../service_calls/service_call.dart';

class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget(
      {super.key,
      required this.text,
      required this.image,
      required this.top,
      required this.index});

  final String text;
  final String image;
  final double top;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (index == 0) {
                Provider.of<AddNewServiceCallNotifier>(context, listen: false)
                    .validationError = '';

                return const ScreenAddNewCall();
              } else if (index == 1) {
                return const ScreenServiceCalls();
              } else if (index == 2) {
                return const ScreenCustomerView();
              } else if (index == 3) {
                return const ScreenProductView();
              } else {
                Provider.of<BillingNotifier>(context, listen: false)
                    .clearDataFromController(context);
                Provider.of<AddProductToBillNotif>(context, listen: false)
                    .customerBillData
                    .clear();
                Provider.of<AddProductToBillNotif>(context, listen: false)
                    .customerBillDataKeys
                    .clear();
                return const ScreenBilling();
              }
            },
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 8,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: top,
                left: 40,
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(image),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: text == "Product and Details" ? 45 : 55, left: 10),
              child: SizedBox(
                width: 160,
                height: text == "Product and Details" ? 50 : 40,
                child: Text(text,
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w600)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
