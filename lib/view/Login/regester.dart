import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/login/login_page_provider.dart';
import 'package:service_manager/controller/provider/register/register_page_provider.dart';

import '../../core/colors.dart';

class ScreenRegisterAccount extends StatelessWidget {
  ScreenRegisterAccount({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
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
          child: ListView(
            padding: const EdgeInsets.only(top: 200),
            children: [
              Center(
                child: Text('Sign Up ',
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
                          contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        ),
                        onChanged: (value) => Provider.of<RegisterNotifier>(
                                context,
                                listen: false)
                            .emailvalidation(value)),
                  ),
                ),
              ),
              Consumer<RegisterNotifier>(
                  builder: (context, registerNotifier, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    registerNotifier.validationError[0],
                    style: TextStyle(color: Colors.red, fontSize: 11),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 58,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 3,
                    child: TextFormField(
                        controller: password,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          hintText: 'Password',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        ),
                        onChanged: (value) => Provider.of<RegisterNotifier>(
                                context,
                                listen: false)
                            .passwordvalidation(value)),
                  ),
                ),
              ),
              Consumer<RegisterNotifier>(
                  builder: (context, registerNotifier, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    registerNotifier.validationError[1],
                    style: TextStyle(color: Colors.red, fontSize: 11),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                        controller: confirmpassword,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          hintTextDirection: TextDirection.ltr,
                          hintText: 'Confirm Password',
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, bottom: 2),
                        ),
                        onChanged: (value) => Provider.of<RegisterNotifier>(
                                context,
                                listen: false)
                            .confirmpasswordvalidation(value)),
                  ),
                ),
              ),
              Consumer<RegisterNotifier>(
                  builder: (context, registerNotifier, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    registerNotifier.validationError[2],
                    style: TextStyle(color: Colors.red, fontSize: 11),
                  ),
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Consumer<RegisterNotifier>(
                  builder: (context, registerNotifier, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    registerNotifier.validationError[3],
                    style: TextStyle(color: Colors.red, fontSize: 11),
                  ),
                );
              }),
              InkWell(
                  onTap: () {
                    Provider.of<SignInNotifier>(context, listen: false)
                        .validationError = ['', '', ''];
                    Navigator.pop(
                      context,
                    );
                  },
                  child: Center(
                    child: const Text('Go to Sign In',
                        style: TextStyle(color: clrDarkBlue)),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 160),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: clrDarkBlue, // Background color
                    ),
                    onPressed: () {
                      bool condition1 = false;
                      bool condition2 = false;
                      bool condition3 = false;
                      condition1 =
                          Provider.of<RegisterNotifier>(context, listen: false)
                              .emailvalidation(email.text);
                      condition2 =
                          Provider.of<RegisterNotifier>(context, listen: false)
                              .passwordvalidation(password.text);
                      if (condition2) {
                        condition3 = Provider.of<RegisterNotifier>(context,
                                listen: false)
                            .confirmpasswordvalidation(
                          confirmpassword.text,
                        );
                      }
                      if (condition1 && condition2 && condition3) {
                        Provider.of<RegisterNotifier>(context, listen: false)
                            .signup(email.text, password.text, context);
                      }
                    },
                    child: const Text('Sign Up')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
