import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_manager/view/widget/screeen_search.dart';
import '../view/new_call_adding/new_call_adding.dart';
import 'colors.dart';

// --Email Validation RegExp

RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

// --AppBar Widget--

// AppBar appBar(BuildContext context,String text) => AppBar(
//       leading: Align(
//           alignment: Alignment.topLeft,
//           child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.arrow_back))),
//       elevation: 0,
//       toolbarHeight: 130,
//       backgroundColor: Colors.transparent,
//       flexibleSpace: ClipPath(
//         clipper: BottomCircleClipper(),
//         child: Container(
//           height: 256,
//           width: double.infinity,
//           color: KColors.clrDarkBlue,
//           child: Center(
//               child: Text(text,
//                   style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white))),
//         ),
//       ),
//     );

// AppBar appBar2(BuildContext context, String text) => AppBar(
//   leading: Container(), // Empty container to remove the default back button
//   toolbarHeight: 100,
//   backgroundColor: Colors.transparent, // Set the background color to transparent
//   flexibleSpace: Container(
//     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//     decoration: BoxDecoration(
//       color: KColors.clrDarkBlue, // Replace with your desired color for the red side
//     ),
//     child: Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: EdgeInsets.only(left: 16), // Adjust the padding as needed
//         child: Text(
//           text,
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ),
//   ),
// );

class AppBarWidget extends StatelessWidget {
   AppBarWidget({
    super.key,required this.text, this.collectionOfDatasKeys, this.collectionOfDatas, this.screenName
  });
String text;
String? screenName;
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
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back,color: Colors.white,),),

        screenName==null ?SizedBox():
        IconButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => ScreenSearch(collectionOfDatas: collectionOfDatas!, collectionOfDatasKeys: collectionOfDatasKeys!, screenName: screenName!),));
        }, icon:Icon(Icons.search,color: Colors.white,size: 25,))
        
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
