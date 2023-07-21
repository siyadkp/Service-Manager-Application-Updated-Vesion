import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/cosnt_values.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/costomeradding/screen_customer_adding_and_updating.dart';
import 'package:service_manager/view/customer_view.dart/widget/customer_view_singlewidget.dart';

class ScreenCustomerView extends StatelessWidget {
  const ScreenCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<AddCustomerNotifier>(
            builder: (context, addCustomerNotifier, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Padding(
              //   padding: EdgeInsets.only(top: 25, bottom: 25),
              //   child: SearchBarWidget(),
              // ),
              // SizedBox(
              //   width: double.infinity,
              //   child: SingleChildScrollView(
              //     padding: const EdgeInsets.only(bottom: 25),
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: [
              //         kWidth20,
              //         RadioSearchSortingWidget(name: 'Name'),
              //         kWidth5,
              //         RadioSearchSortingWidget(name: 'Phone'),
              //         kWidth5,
              //         RadioSearchSortingWidget(name: 'Place'),
              //         kWidth5,
              //         RadioSearchSortingWidget(name: 'Address'),
              //         kWidth20
              //       ],
              //     ),
              //   ),
              // ),
              AppBarWidget(
                  text: 'Customers',
                  collectionOfDatas: addCustomerNotifier.customerDatas,
                  collectionOfDatasKeys: addCustomerNotifier.customerKeys,
                  screenName: allScreenNames[7]),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Place',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    (addCustomerNotifier.customerDatas.isEmpty)
                        ? Center(
                            child: Text(
                            'No Customers',
                            style: TextStyle(fontSize: 20),
                          ))
                        : ListView.separated(
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, right: 15),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 2,
                            ),
                            itemBuilder: (context, index) {
                              return CustomerViewSingleWidget(
                                customerData: addCustomerNotifier
                                        .customerDatas[
                                    addCustomerNotifier.customerKeys[index]],
                              );
                            },
                            itemCount: addCustomerNotifier.customerDatas.length,
                          )
                  ],
                ),
              ),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: KColors.clrDarkBlue,
          child: const Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
          Provider.of<AddCustomerNotifier>(context,listen: false).controllerClear();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCustomerAddingAndUpdating(oldCUstomerName: "",
                      appBarText: "Customer Adding", genderStatus: "Mr")),
            );
          },
        ),
      ),
    );
  }
}
