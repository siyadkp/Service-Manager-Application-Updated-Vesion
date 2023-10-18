import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_manager/view/widget/screeen_search.dart';
import '../view/new_call_adding/new_call_adding.dart';
import 'colors.dart';

// --Email Validation RegExp

RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {super.key,
      required this.text,
      this.collectionOfDatasKeys,
      this.collectionOfDatas,
      this.screenName});
  final String text;
  final String screenName;
  List<String>? collectionOfDatasKeys;
  Map<String, QueryDocumentSnapshot<Object?>>? collectionOfDatas;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomCircleClipper(),
      child: Container(
        height: 140,
        width: double.infinity,
        color: KColors.clrDarkBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                screenName == null
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScreenSearch(
                                    collectionOfDatas: collectionOfDatas!,
                                    collectionOfDatasKeys:
                                        collectionOfDatasKeys!,
                                    screenName: screenName!),
                              ));
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ))
              ],
            ),
            Center(
                child: Text(text,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
