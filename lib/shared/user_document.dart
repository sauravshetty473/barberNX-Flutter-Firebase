import 'package:barber_nx/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDocument {
  //class properties
  String firstname;
  String lastname;

  //constructor
  UserDocument({ required this.firstname, required this.lastname});

  // factory constructor that returns a new instance
  factory UserDocument.fromFirebase(DocumentSnapshot documentSnapshot) {
    return UserDocument(
        firstname : documentSnapshot.get('firstname'),
        lastname : documentSnapshot.get('lastname'));
  }

  static Stream<UserDocument?>? getUserDocument({String? id}) {
    if(id == null) return null;
    return Database.user.doc(id).snapshots().map((e) =>
        UserDocument.fromFirebase(e));
  }
}



class GustavProvider extends StatelessWidget{
  const GustavProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamProvider<UserDocument?>.value(
      value: UserDocument.getUserDocument(id: '8cHtoqEUqh9Y1UWIZWq0'),

      initialData: null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserCard(),
      ),
    );
  }
}


class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDocument = Provider.of<UserDocument?>(context);
    return Scaffold(
      body: userDocument == null?const SizedBox():
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                userDocument.firstname
            ),
            Text(
                userDocument.lastname
            ),

          ],
        ),
      ),
    );
  }
}

