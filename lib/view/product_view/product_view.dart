import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/widget/search_bar_widget.dart';
import '../../controller/provider/search/const_search_objects.dart';
import '../../controller/provider/search/search_provider.dart';
import 'widget/single_product_view_widget.dart';

class ScreenProductView extends StatelessWidget {
  const ScreenProductView({super.key});

  @override
  Widget build(BuildContext context) {
   AdminAddProductNotifier adminAddProductNotifierObj= Provider.of<AdminAddProductNotifier>(context,listen: false);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
         resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              child: Consumer<TrieNotifier>(
                builder: (context, trieNotifier, _)  {
                  return Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 140),
                      child: SizedBox(
                          height: size.height,
                          child:
                              NotificationListener<OverscrollIndicatorNotification>(
                                  onNotification: (overscroll) {
                                    overscroll.disallowIndicator();
                                    return true;
                                  },
                                  child: productsViewScreenSearchNotifierObject.collectionOfDatas.isEmpty ? const Center(
                                       child: Text('No Listed Products',style: 
                                       TextStyle(fontSize: 25,color: Colors.grey),),
                                     ):ListView.builder(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 7, top: 0),
                                      itemBuilder: (context, index) {
                                    return  SIngleProductViewWidget(productData:productsViewScreenSearchNotifierObject.collectionOfDatas[productsViewScreenSearchNotifierObject.collectionOfDatsKeys[index]]);                   
                },  itemCount: productsViewScreenSearchNotifierObject.collectionOfDatas.length),),),
                    ),
                    Card(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Container(
                            width: double.infinity,
                            height: 140,
                            color: clrDarkBlue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                 SearchBarWidget(searchingDatas:adminAddProductNotifierObj.productDatas,keyValues: adminAddProductNotifierObj.productsKeys,screenName: allScreenNames[6] ),
                              ],
                            ),),),
                  ],);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
