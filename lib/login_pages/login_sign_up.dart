import 'package:barber_nx/login_pages/login.dart';
import 'package:barber_nx/login_pages/register.dart';
import 'package:flutter/material.dart';




class LoginSignUp extends StatefulWidget {


  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {

  void switcher(){
    setState(() {
      login = !login;
    });
  }

  bool login = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(

          color: Colors.white,
          width: double.infinity,
          height: double.infinity,

          child: Image.asset('assets/images/back.jpg', fit: BoxFit.cover, alignment: Alignment.centerLeft),


        ),


        login?Login(switcher): SignUp(switcher)
      ],
    );
  }
}
