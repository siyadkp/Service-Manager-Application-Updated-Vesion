import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/widget/screeen_search.dart';
import '../callstatusupdation/call_status_updation.dart';
import 'widget/service_callview_singlewidget.dart';

class ScreenServiceCalls extends StatelessWidget {
  const ScreenServiceCalls({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: KColors.clrDarkBlue,
              margin: const EdgeInsets.all(0),
              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25) ) ),
              elevation: 5,
              child: Container(
               
  decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25) ) ),
                height: 120,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 35,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenSearch(
                                      collectionOfDatas: Provider.of<AddNewServiceCallNotifier>(context,listen:false).callDatas,
                                      collectionOfDatasKeys:Provider.of<AddNewServiceCallNotifier>(context,listen:false).callDataKeys ,
                                      screenName: allScreenNames[8]),
                                ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Icon(
                              Icons.search,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Consumer<AddNewServiceCallNotifier>(
                    builder: (context, addNewServiceCallNotifier, child) {
                      return addNewServiceCallNotifier.callDatas.isEmpty
                          ? const Center(
                              child: Text(
                              'No data found for the call',
                              style: TextStyle(fontSize: 20),
                            ))
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.only(top: 30, left: 10, right: 12),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 5,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Provider.of<ServiceCallStatusUpdationNotifier>(
                                              context,
                                              listen: false)
                                          .navigatToUpdateStatusPage(
                                              addNewServiceCallNotifier
                                                      .callDatas[
                                                  addNewServiceCallNotifier
                                                      .callDataKeys[index]]!);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScreenCallStatusUpdation(
                                                  docId: addNewServiceCallNotifier
                                                      .callDatas[
                                                          addNewServiceCallNotifier
                                                                  .callDataKeys[
                                                              index]]!
                                                      .id,
                                                  customerName:
                                                      addNewServiceCallNotifier
                                                          .callDatas[
                                                              addNewServiceCallNotifier
                                                                      .callDataKeys[
                                                                  index]]
                                                          ?.get('customer'),
                                                )),
                                      );
                                      ;
                                    },
                                    child: ServicallViewSingleWidget(
                                        serviceCallData:
                                            addNewServiceCallNotifier.callDatas[
                                                addNewServiceCallNotifier
                                                    .callDataKeys[index]]));
                              },
                              itemCount:
                                  addNewServiceCallNotifier.callDatas.length,
                            );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
