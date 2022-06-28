import 'package:barber_nx/barber_profile/bp_external.dart';
import 'package:barber_nx/home/home.dart';
import 'package:barber_nx/shared/fiverr.dart';
import 'package:barber_nx/shared/home_screen.dart';
import 'package:barber_nx/user_profile/up_external.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: GoogleFonts.inter().fontFamily
      ),

      home: UPExternal()
    );
  }
}