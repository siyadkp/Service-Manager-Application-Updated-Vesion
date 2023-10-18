import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/search/search_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/naming.dart';
import '../../controller/provider/search/const_search_objects.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget(
      {super.key,
      required this.searchingDatas,
      required this.keyValues,
      required this.screenName});
  final Map<String, QueryDocumentSnapshot> searchingDatas;
  final List<String> keyValues;
  final String screenName;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: KColors.clrDarkBlue)),
        child: TextField(
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
          decoration: const InputDecoration(
            hintText: 'Search',
            suffixIcon: Icon(Icons.search),
            hintStyle: TextStyle(color: Colors.black45),
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          onChanged: (value) {
            if (screenName == allScreenNames[6]) {
              Provider.of<TrieNotifier>(context, listen: false).searchHelper(
                  searchingDatas,
                  keyValues,
                  value,
                  productsViewScreenSearchNotifierObject);
            } else if (screenName == allScreenNames[7]) {
              Provider.of<TrieNotifier>(context, listen: false).searchHelper(
                  searchingDatas,
                  keyValues,
                  value,
                  customerViewScreenSearchNotifierObject);
            } else if (screenName == allScreenNames[8]) {
              Provider.of<TrieNotifier>(context, listen: false).searchHelper(
                  searchingDatas,
                  keyValues,
                  value,
                  serviceCallViewScreenSearchNotifierObject);
            }
          },
        ),
      ),
    );
  }
}
