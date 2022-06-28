import 'dart:async';
import 'dart:math';

import 'package:barber_nx/shared/fiverr.dart';
import 'package:barber_nx/shared/universal_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


const kPrimaryColor = Colors.red;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final auth = FirebaseAuth.instance;
  // static final uid = FirebaseAuth.instance.currentUser!.uid;
  int _actualPage = 0;
  final List<Widget> _pages = [
    const FiverrAnimation(),
    Container(),
    Container()
  ];

  @override
  void initState() {
    super.initState();
    // update();
    // downloadUrl();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>UniversalTimer(),
      child: Scaffold(
        //drawer: const NavbarScreen(),
        appBar: AppBar(
          //systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: const Text('Datezzle',
              style: TextStyle(fontFamily: 'Noto Serif', color: kPrimaryColor)),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kPrimaryColor),
          // leading:  ,
          actions: [
            // IconButton(
            //     color: kPrimaryColor,
            //     onPressed: () {
            //       keepLogin();
            //       auth.signOut();
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(
            //           builder: ((context) => const WelcomeScreen())));
            //     },
            //     icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: _pages[_actualPage],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: kPrimaryColor,
            onTap: (index) {
              setState(() {
                _actualPage = index;
              });
            },
            currentIndex: _actualPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.play_arrow),
                label: "Play ",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message_outlined), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile")
            ]),
      ),

    );
  }
  //
  // // Keep log a false
  // keepLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.setBool("log", false);
  //     prefs.setString('name', "");
  //     prefs.setString('birthday', "");
  //     prefs.setString('age', "");
  //     prefs.setString('location', "");
  //     prefs.setString('urlImage', "");
  //   });
  // }
  //
  // update() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc(uid)
  //       .get()
  //       .then((results) => {
  //     prefs.setString('name', results["name"]),
  //     prefs.setString('birthday', results["birthday"]),
  //     prefs.setString('location', results["location"]),
  //     prefs.setString('age', results["age"]),
  //   });
  // }
  //
  // // Down load url image
  // Future<String> downloadUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   String url = await storage.ref('profileImage/$uid').getDownloadURL();
  //
  //   prefs.setString('urlImage', url);
  //
  //   return url;
  // }
}
