

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_manager/view/home/home.dart';
import '../../../core/cosnt_values.dart';

class RegisterNotifier with ChangeNotifier{
  List<String>validationError=['','','',''];

  
  
  String? password;
   
  bool emailvalidation(String email){
    if(email.isEmpty){
      validationError[0]='Email is empty';
      notifyListeners();
      return false;
    }else if (!emailRegex.hasMatch(email)) {
      validationError[0]='Invalid email address';
      notifyListeners();
      return false;
    }else{
      validationError[0]='';
      notifyListeners();
      return true;
    }
    
  } 
  
    bool passwordvalidation(String value){
    if(value.isEmpty){
      validationError[1]='password is empty';
      notifyListeners();
      return false;
    }else{
      password=value;
      validationError[1]='';
      notifyListeners();
      return true;
    }
    
     
  } 
    bool confirmpasswordvalidation(String confirmpassword){
    if(confirmpassword!=password){
      validationError[2]='confirm password is not mached';
       notifyListeners();
      return false;
    }
    else{
      validationError[2]='';
       notifyListeners();
      return true;
    }
  }

  signup(String email,String password,BuildContext context)async{
   
        try {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email:email , password: password);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ScreenHome(),));
} on FirebaseAuthException catch (e) {
 validationError[3]=e.message.toString();
 notifyListeners();
}
        
    
    
  }
}