import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpUserWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e)
    {
      print("Error Occured");
    }
    return null;
  }

  Future<User?> signInUserWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e)
    {
      print("Error Occured");
    }
    return null;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}