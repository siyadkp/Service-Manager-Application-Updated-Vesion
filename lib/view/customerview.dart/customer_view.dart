import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_customer_provider/add_customer_provider.dart';
import 'package:service_manager/controller/provider/search/const_search_objects.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/costomeradding/costomer_adding.dart';
import 'package:service_manager/view/customerview.dart/widget/customer_view_singlewidget.dart';
import 'package:service_manager/view/widget/screeen_search.dart';

class ScreenCustomerView extends StatelessWidget {
  const ScreenCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    AddCustomerNotifier addCustomerNotifierObj =
        Provider.of<AddCustomerNotifier>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8, bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 5),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenSearch(
                                    collectionOfDatas:
                                        addCustomerNotifierObj.customerDatas,
                                    collectionOfDatasKeys:
                                        addCustomerNotifierObj.customerKeys,
                                    screenName: allScreenNames[7]),
                              ));
                        },
                        child:  Icon(
                          Icons.search,
                          size: 40,
                          color: KColors.clrDarkBlue,
                        )),
                  )
                ],
              ),
            ),
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
                  Consumer<AddCustomerNotifier>(
                      builder: (context, addCustomerNotifier, _) {
                    if (addCustomerNotifier.customerDatas.isEmpty) {
                      return Center(
                          child: Text(
                        'No Customers',
                        style: TextStyle(fontSize: 20),
                      ));
                    }
                    return ListView.separated(
                      padding:
                          const EdgeInsets.only(top: 5, left: 15, right: 15),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 2,
                      ),
                      itemBuilder: (context, index) {
                        return CustomerViewSingleWidget(
                          customerData: addCustomerNotifier.customerDatas[
                              addCustomerNotifier.customerKeys[index]],
                        );
                      },
                      itemCount: addCustomerNotifier.customerDatas.length,
                    );
                  }),
                  Positioned(
                      bottom: 5,
                      right: 15,
                      child: FloatingActionButton(
                        backgroundColor: KColors.clrDarkBlue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ScreenCustomerAdding(),
                              ));
                        },
                        child: const Icon(Icons.person_add_alt_1),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
