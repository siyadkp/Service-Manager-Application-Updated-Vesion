import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/core/sizing.dart';
import '../../../controller/provider/billing_provider/billing_provider.dart';
import '../addbillproduct/widget/customer_call_widget.dart';

List<CustomerCallWidget> addProductSingleWidgetBuilderObj = [];

class ServiceCallAddingWidget extends StatelessWidget {
  ServiceCallAddingWidget({super.key,});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight20,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              'Service Calls',
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        kHeight20,
        SizedBox(
          height: 200,
          width: 385,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Consumer<BillingNotifier>(
              builder:(context, billingNotifier, child)  {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    addProductSingleWidgetBuilderObj.add(
                      CustomerCallWidget(
                        callData: billingNotifier.singleCustomerCompletedCalls[
                            billingNotifier
                                .singleCustomerCompletedCallsKeys[index]],
                        index: index,
                      ),
                    );
                    return addProductSingleWidgetBuilderObj[index];
                  },
                  itemCount: billingNotifier.singleCustomerCompletedCalls.length,
                );
              }
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
          height: 0,
        )
      ],
    );
  }
}
