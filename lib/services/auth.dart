import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AuthService{
  static final FirebaseAuth _auth= FirebaseAuth.instance;             //creating an object

  Stream<User?> get user{                                      //<> Tell us about the type of data we receive  (getter)
    return _auth.authStateChanges();
  }


  static Future registerWithEmailPassword(String email , String password) async {                                     //register
    try{
      UserCredential? result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      
      if(user == null){
        throw Exception('user is null');
      }

      // ignore: void_checks
      await user.sendEmailVerification().whenComplete(() {
        if(user.emailVerified){
          Fluttertoast.showToast(msg: "Email Verification sent");
        }
        else{
          Fluttertoast.showToast(msg: "The email address is already verified");
        }
        return user;
      });
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future signInWithEmailPassword(String email , String password) async {                                     //sign In
    try{
      await _auth.signOut();
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }
    catch(e){
      return null;
    }
  }


  static Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      return null;
    }
  }

}