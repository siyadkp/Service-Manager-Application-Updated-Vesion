import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/core/sizing.dart';

import '../../controller/provider/login/login_page_provider.dart';
import '../Login/sign_in.dart';
import 'widget/widget.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    )),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  SettingsWidget(
                      icon: Icons.info,
                      text: 'About Service Maneger',
                      lasticon: true),
                  kHeight20,
                  SettingsWidget(
                      icon: Icons.note_sharp,
                      text: 'Terms and Condition',
                      lasticon: true),
                  kHeight20,
                  SettingsWidget(
                      icon: Icons.privacy_tip,
                      text: 'Privacy and Policy',
                      lasticon: true),
                  kHeight20,
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) => 
                           AlertDialog(
                            title: Text('Warning'),
                            content: Text('Are you sure you want to log out? You will be redirected to the login page.'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  
                                },
                              ),
                              TextButton(
                                child: Text('Sign out',style: TextStyle(color: Colors.red),),
                                onPressed: () async{
                                    Provider.of<SignInNotifier>(context,listen: false).validationError=['','',''];
                                    final FirebaseAuth _auth = FirebaseAuth.instance;
                                    await _auth.signOut();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScreenSignIn(),
                                      ),
                                      (route) => false);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: SettingsWidget(
                          icon: Icons.logout_outlined,
                          text: 'Sign out',
                          lasticon: false)),
                  kHeight20,
                  const Text(
                    'version1.1.0',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
