// import 'package:flutter/material.dart';
// import 'package:service_manager/core/sizing.dart';

// import '../calldetailsview/call_details_view.dart';

// class ScreenDelivery extends StatelessWidget {
//   const ScreenDelivery({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.only(top: 30),
//           child: Column(
//             children: [
//               const Text(
//                 'Delivery',
//                 style: TextStyle(fontSize: 25),
//               ),
//               TextWIdget(text1: 'Coustomer:', text2: 'Sahil Saleem'),
//               TextWIdget(
//                   text1: 'Phone :',
//                   text2: '9845103698',
//                   textsize1: 20,
//                   textsize2: 17),
//               TextWIdget(
//                   text1: 'Date:',
//                   text2: 'Apr 22/2023',
//                   textsize1: 20,
//                   textsize2: 17),
//               TextWIdget(
//                   text1: 'Billing Address :',
//                   text2: '',
//                   textsize1: 18,
//                   textsize2: 17),
//             Padding(
//               padding: const EdgeInsets.only(left: 5,right: 10,top: 80),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Product and Details',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
//                   Divider(color: Colors.grey,thickness: 3),
//                   Container(
                
//                     width: double.infinity,
//                     height: 220,
//                     child: ListView.builder(
//                             itemBuilder: (context, index) {
                              
                            
//                         return CustomerViewSingleWidget();
//                       },
//                       itemCount: 4,
//                     ),
//                   ),
//                    Divider(color: Colors.grey,thickness: 3),
            
//                 ],
//               ),
//             ),
//              Padding(
//                    padding: const EdgeInsets.only(top: 25,bottom: 20),
//                    child: Text('Total Amount : 3679',style:TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
//                  ),
            
//               ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Edit Call Details'),
//               ),
//               kHeight20
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// class CustomerViewSingleWidget extends StatelessWidget {
//   const CustomerViewSingleWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         color: const Color.fromRGBO(202, 226, 232, 100),
//         child: Container(
          
//           height: 60,
//           width: 390,
//           decoration: BoxDecoration( borderRadius: BorderRadius.circular(15)),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Checkbox(value:false, onChanged: (value) {
                  
//                 },),
//                 Text('C23/588 ',
//                     style: TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.w600)),
//                 kWidth15,
//                 Text(
//                   'Hp Latitude 4950',
//                   style:
//                       TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//                 kWidth15,
//                 Text(
//                   'Apr 20 /2023',
//                   style:
//                       TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//                 kWidth15,
//                   Text(
//                   'Printer Service',
//                   style:
//                       TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//                 kWidth15,
//                 Text(
//                   '₹5578',
//                   style:
//                       TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
                
                
               
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

