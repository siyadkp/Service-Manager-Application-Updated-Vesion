import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';
import 'package:service_manager/core/cosnt_values.dart';
import 'package:service_manager/core/naming.dart';
import '../callstatusupdation/call_status_updation.dart';
import 'widget/service_callview_singlewidget.dart';

class ScreenServiceCalls extends StatelessWidget {
  const ScreenServiceCalls({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body:   Consumer<AddNewServiceCallNotifier>(
                    builder: (context, addNewServiceCallNotifier, _) {
            return Column(
              children: [
                AppBarWidget(text: 'Service Calls',screenName:allScreenNames[8] ,collectionOfDatas: addNewServiceCallNotifier.callDatas,collectionOfDatasKeys:addNewServiceCallNotifier.callDataKeys ),
                Expanded(
                  child: Stack(
                    children: [
                      addNewServiceCallNotifier.callDatas.isEmpty
                          ? const Center(
                              child: Text(
                                'No data found for the call',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : SizedBox(
                              width: 390,
                              child: ListView.separated(
                                shrinkWrap: true,
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
                                                          .callDataKeys[index]]!
                                                  .id,
                                              customerName:
                                                  addNewServiceCallNotifier
                                                      .callDatas[
                                                          addNewServiceCallNotifier
                                                                  .callDataKeys[
                                                              index]]
                                                      ?.get('customer'),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ServicallViewSingleWidget(
                                          serviceCallData:
                                              addNewServiceCallNotifier
                                                      .callDatas[
                                                  addNewServiceCallNotifier
                                                      .callDataKeys[index]]));
                                },
                                itemCount:
                                    addNewServiceCallNotifier.callDatas.length,
                              ),
                            ),
                    ],
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
