import 'package:barber_nx/services/auth.dart';
import 'package:barber_nx/shared/user_document.dart';
import 'package:barber_nx/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GustavProvider());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,

      initialData: null,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper()
      ),
    );
  }}




