

import 'package:flutter/material.dart';
import 'package:flutterdoo/models/user.dart';
import 'package:flutterdoo/providers/task_provider.dart';
import 'package:flutterdoo/services/firebase_service.dart';
import 'package:flutterdoo/services/shared_service.dart';
import 'package:provider/provider.dart';

class AuthenticationProvider extends ChangeNotifier{
  UserModel? currentUser;
  FirebaseAuthService _authService = FirebaseAuthService();

  Future<UserModel?> login({required String email,required String password}) async
  {
        try{
          var user = await _authService.signInUserWithEmailAndPassword(email, password);
          SharedPreferenceService.isLogin = true;
          SharedPreferenceService.username = user!.uid;
          notifyListeners();
          currentUser = UserModel(id: user!.uid, username: user!.uid, name: user!.uid, email: user.email!);
          return currentUser;
        }catch(e){
          rethrow;
        }
  }



  Future<UserModel?> register({required String email,required String password}) async
  {
    try{
      var user = await _authService.signUpUserWithEmailAndPassword(email, password);
      notifyListeners();
      currentUser = UserModel(id: user!.uid, username: user!.uid, name: user!.uid, email: user.email!);
      return currentUser;
    }catch(e){
      rethrow;
    }
  }

  Future<void> logout () async {
    SharedPreferenceService.isLogin = false;
    SharedPreferenceService.username = "test";
    _authService.signOut();
    notifyListeners();
     TaskProvider taskProvider = TaskProvider();
     taskProvider.logout();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    currentUser = null;
    super.dispose();
  }

}