import 'package:flutter/material.dart';
import 'package:barber_nx/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {
  Function switcher;
  Login(this.switcher);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool loading = false;
  String email= '';
  String password= '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),



      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Container(

              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(1), Colors.black.withOpacity(0.5)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onChanged: (val){
                      email = val;
                    },

                    validator : (val){
                      if((val??'').isEmpty) return 'email field is blank';
                      bool pass = EmailValidator.validate('val');
                      if(pass) {
                        return null;
                      } else {
                        return 'Please enter a valid email address';
                      }

                    },
                    textAlign: TextAlign.center,


                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: 'email address',


                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5)
                      ),

                      fillColor: Colors.black.withOpacity(0.5),
                      filled: true,
                      border: InputBorder.none,


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),

                        ),
                      ),
                    ),
                  ),





                  const SizedBox(height: 20,),




                  TextFormField(

                    onChanged: (val){
                      password = val;
                    },

                    validator: (val){
                      if((val??'').isEmpty) return 'password is blank';

                      if((val??'').length<3) return 'min length is 3';
                    },
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(

                      hintText: 'password',
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5)
                      ),
                      fillColor: Colors.black.withOpacity(0.5),
                      filled: true,
                      border: InputBorder.none,



                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),


                  GestureDetector(
                    onTap: () async{
                      setState(() {
                        loading = true;
                      });

                      await AuthService.signInWithEmailPassword(email, password);

                      setState(() {
                        loading = false;
                      });

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: loading?
                      const CircularProgressIndicator()
                          :const Text(
                        'Log in',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 10,),


                  const Text(
                    'OTHER SIGN IN OPTIONS',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),


                  const SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      GestureDetector(
                        onTap: () async{
                          final googleSignIn = GoogleSignIn();
                          GoogleSignInAccount? _user;

                          final googleUser = await googleSignIn.signIn();
                          if(googleUser == null) return;
                          _user = googleUser;

                          final googleAuth = await googleUser.authentication;

                          final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken,
                          );

                          await FirebaseAuth.instance.signInWithCredential(credential);
                        },
                          child: Image.asset('assets/images/glogo.png', width: 40, height: 40,)),
                      const SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () async{
                          final FacebookLogin facebookSignIn =  FacebookLogin();

                          final FacebookLoginResult result =
                          await facebookSignIn.logIn(['email']);

                          final FacebookAccessToken accessToken = result.accessToken;

                          final facebookAuthCredential =  await FacebookAuthProvider.credential(accessToken.token);

                          await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);


                        },

                          child: Image.asset('assets/images/fblogo.png', width: 40, height: 40,)),
                    ],
                  ),



                  const SizedBox(height: 10,),
                  const Divider(color: Colors.white),
                  const SizedBox(height: 20,),


                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        widget.switcher();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

