import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdoo/screens/splash_screen.dart';
import 'package:flutterdoo/services/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpUserWithEmailAndPassword(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        // Throw an exception if email or password is empty
        throw FirebaseAuthException(
          code: 'invalid-input',
          message: 'Email and password cannot be empty',
        );
      }
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        // Handle specific Firebase authentication errors
        String errorMessage = 'An error occurred while signing up';

        // Customize error messages based on the error code
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'The account already exists for that email';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid';
            break;
          case 'operation-not-allowed':
            errorMessage = 'Account creation is not allowed';
            break;
          case 'weak-password':
            errorMessage = 'The password is too weak, length should be greater than 6';
            break;
          default:
            errorMessage = 'Unhandled Firebase Auth error: ${e.code}';
            break;
        }

        // Print the error message for debugging purposes
        print('Firebase Auth Error: $errorMessage');

        // Rethrow the exception to propagate it up the call stack
        throw FirebaseAuthException(
          code: e.code,
          message: errorMessage,
        );
      }

      rethrow;

      // Print other unexpected errors for debugging purposes

      // Return null to indicate failure
      return null;
    }
  }

  Future<User?> signInUserWithEmailAndPassword(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        // Throw an exception if email or password is empty
        throw FirebaseAuthException(
          code: 'invalid-input',
          message: 'Email and password cannot be empty',
        );
      }

      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } catch (e) {
      // Handle specific Firebase authentication errors
      if (e is FirebaseAuthException) {
        String errorMessage = 'An error occurred while signing in';

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid Email';
        } else if (e.code == 'user-disabled') {
          errorMessage = 'This User is Disabled';
        } else if (e.code == 'invalid-credential') {
          errorMessage = 'The Credentials are invalid';
        }

        // Throw a more specific exception with a custom error message
        throw FirebaseAuthException(
          code: e.code,
          message: errorMessage,
        );
      }

      // Rethrow any other exceptions
      rethrow;
    }
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    SharedPreferenceService.isLogin = false;
  }
}