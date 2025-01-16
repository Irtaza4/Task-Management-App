import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreenProvider with ChangeNotifier{

  bool _isInitialized = false;
  User?  _user;
  bool get isInitialized => _isInitialized;
  User? get user => _user;
  SplashScreenProvider(){
  initialized();
  }
  Future<void> initialized() async{

    await Future.delayed(Duration(seconds: 2));

    _user = FirebaseAuth.instance.currentUser;

    _isInitialized=true;
    notifyListeners();
  }

}