import 'package:cloud_firestore/cloud_firestore.dart';


class Database{
  //collection reference .... firebase google collections
  static final CollectionReference bShop = FirebaseFirestore.instance.collection('BShop') ;
}