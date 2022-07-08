import 'package:barber_nx/home/home.dart';
import 'package:barber_nx/login_pages/login_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';





class Wrapper extends StatelessWidget  {
  @override
  Widget build(BuildContext context){

    final user = Provider.of<User?>(context);                              //Provider in the child can get values from its parent

    return user==null?LoginSignUp():const Home();                              //at start either Exposition or the Home page //not Authenticate directly
  }
}
