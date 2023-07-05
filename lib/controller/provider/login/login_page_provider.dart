

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_manager/view/adminside/home/home.dart';
import 'package:service_manager/view/home/home.dart';

import '../../../core/cosnt_values.dart';

class SignInNotifier with ChangeNotifier {
 List<String>validationError=['','',''];


  bool emailvalidation(String email) {
    if (email.isEmpty) {
      validationError[0] = 'Email is empty';
      notifyListeners();
      return false;
    } else if (!emailRegex.hasMatch(email)) {
      validationError[0] = 'Invalid email address';
      notifyListeners();
      return false;
    } else {
      validationError[0] = '';
      notifyListeners();
      return true;
    }
  }

  bool passwordvalidation(String value) {
    if (value.isEmpty) {
      validationError[1] = 'password is empty';
      notifyListeners();
      return false;
    } else {
      validationError[1] = '';
      notifyListeners();
      return true;
    }
  }

  signin(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => email=='Admin123@gmail.com' ?ScreenAdminHome() :ScreenHome(),
          ));
    } on FirebaseAuthException catch (e) {
      validationError[2] = e.message.toString();
      notifyListeners();
    }
  }
}
