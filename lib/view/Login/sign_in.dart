import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/login/login_page_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/sizing.dart';
import 'package:service_manager/view/Login/regester.dart';

import '../../controller/provider/register/register_page_provider.dart';

class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({super.key});

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 20,top: 20,bottom: 90),
                //   child: Text('Welcome To Service Manager',style:GoogleFonts.caladea(fontSize: 40,fontWeight: FontWeight.w500)),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height / 4, left: size.width / 3),
                  child: Text('Sign In ',
                      style: GoogleFonts.caladea(
                          fontSize: 40, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  child: SizedBox(
                    height: 58,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                      child: TextFormField(
                        controller: email,
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            hintTextDirection: TextDirection.ltr,
                            hintText: 'Email',
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 0),
                          ),
                          onChanged: (value) => Provider.of<SignInNotifier>(
                                  context,
                                  listen: false)
                              .emailvalidation(value)),
                    ),
                  ),
                ),
                Consumer<SignInNotifier>(
                    builder: (context, signInNotifier, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      signInNotifier.validationError[0],
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  );
                }),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 33,
                  ),
                  child: Text('',
                      style: TextStyle(color: Colors.red, fontSize: 13)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: 58,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 3,
                      child: TextFormField(

                    controller:password,
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            hintTextDirection: TextDirection.ltr,
                            hintText: 'Password',
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 2),
                          ),
                          onChanged: (value) => Provider.of<SignInNotifier>(
                                  context,
                                  listen: false)
                              .passwordvalidation(value)),
                    ),
                  ),
                ),
                Consumer<SignInNotifier>(
                    builder: (context, signInNotifier, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      signInNotifier.validationError[1],
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  );
                }),
              const SizedBox(height: 10,),
                Consumer<SignInNotifier>(
                    builder: (context, signInNotifier, child) {
                  return Center(
                    child: Text(
                      signInNotifier.validationError[2],
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Forgot Password ?',
                            style: TextStyle(color: clrDarkBlue),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Provider.of<RegisterNotifier>(context,listen: false).validationError=['','','',''];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           ScreenRegisterAccount(),
                                    ));
                              },
                              child: const Text('Create an Account',
                                  style: TextStyle(color: clrDarkBlue))),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: clrDarkBlue, // Background color
                          ),
                          onPressed: () {
                            
                             bool condition1 = false;
                      bool condition2 = false;
                   
                      condition1 =
                          Provider.of<SignInNotifier>(context, listen: false)
                              .emailvalidation(email.text);
                      condition2 =
                          Provider.of<SignInNotifier>(context, listen: false)
                              .passwordvalidation(password.text);
                     
                      if (condition1 && condition2) {
                        Provider.of<SignInNotifier>(context, listen: false)
                            .signin(email.text, password.text, context);
                      }
          
                            // Map<String,dynamic>usr={'name':'siyad'};
                            // Map<String,dynamic>usr1={};
                            // // FirebaseFirestore.instance.collection('sampledata').doc('users').set(usr);
                            // DocumentSnapshot data=await FirebaseFirestore.instance.collection('sampledata').doc('users').get();

                            //           if (formKey.currentState!.validate()) {

                            // }
                          },
                          child: const Text('Sign In')),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
