import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/search/search_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/customerview.dart/widget/customer_view_singlewidget.dart';
import 'package:service_manager/view/widget/radio_search_sorting_widget.dart';
import 'package:service_manager/view/widget/search_bar_widget.dart';
import '../../controller/provider/search/const_search_objects.dart';
import '../../core/sizing.dart';
import '../service_calls/widget/service_callview_singlewidget.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch(
      {super.key,
      required this.collectionOfDatas,
      required this.collectionOfDatasKeys,
      required this.screenName});
  Map<String, QueryDocumentSnapshot> collectionOfDatas;
  List<String> collectionOfDatasKeys;
  String screenName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: KColors.clrDarkBlue,
                  size: 35,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 25),
              child: SearchBarWidget(
                  keyValues: collectionOfDatasKeys,
                  screenName: screenName,
                  searchingDatas: collectionOfDatas),
            ),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20, left: 8),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Consumer<TrieNotifier>(
              builder: (context, trieNotifier, _) {

                  
              
                  if (screenName == allScreenNames[8]) {
                    if (serviceCallViewScreenSearchNotifierObject
                    .collectionOfDatas.isEmpty) {
                  return Center(child: Text('No matching results found',style:TextStyle(fontSize: 15,color: Colors.blueGrey),));}
                   else{ return Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 10, right: 12),
                          itemBuilder: (context, index) {
                            return ServicallViewSingleWidget(
                              serviceCallData:
                                  serviceCallViewScreenSearchNotifierObject
                                          .collectionOfDatas[
                                      serviceCallViewScreenSearchNotifierObject
                                          .collectionOfDatsKeys[index]],
                            );
                          },
                          itemCount: serviceCallViewScreenSearchNotifierObject
                              .collectionOfDatas.length),
                    );
                  }} else if (screenName == allScreenNames[7]) {
                     if (customerViewScreenSearchNotifierObject
                    .collectionOfDatas.isEmpty) {
                  return Center(child: Text('No matching results found',style:TextStyle(fontSize: 15,color: Colors.blueGrey),));}
                  else{  return Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return CustomerViewSingleWidget(
                                customerData:
                                    customerViewScreenSearchNotifierObject
                                            .collectionOfDatas[
                                        customerViewScreenSearchNotifierObject
                                            .collectionOfDatsKeys[index]]);
                          },
                          itemCount: customerViewScreenSearchNotifierObject
                              .collectionOfDatas.length),
                    );
                   } }
                  return Text('');
               
              },
            )
          ],
        ),
      ),
    );
  }
}
