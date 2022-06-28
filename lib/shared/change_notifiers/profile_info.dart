import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfo with ChangeNotifier{
  late String _fname;
  late String _lname;
  late int _gender;
  late DateTime _joinDate;
  late String _ppUrl;

  late File _pp;
  bool _saveState = false;      // saving in progress is true


  ProfileInfo(DocumentSnapshot e){
    _fname = e.get('fname');
    _lname = e.get('lname');
    _gender = e.get('gender');
    _joinDate = e.get('join').toDate();
    _ppUrl = e.get('pp');
  }

  String get fname => _fname;
  String get lname => _lname;
  int get gender => _gender;
  DateTime get join => _joinDate;
  bool get saveState => _saveState;
  File get pp => _pp;
  String get ppUrl => _ppUrl;




  Future<void> save() async{
    _saveState = true;
    notifyListeners();

    //
    // final String rand1 = "${Random().nextInt(10000)}";
    // final String rand2 = "${Random().nextInt(10000)}";
    // final String rand3 = "${Random().nextInt(10000)}";
    // final StorageReference ref = FirebaseStorage.instance.ref().child('${rand1}_${rand2}_$rand3.jpg');
    // final StorageUploadTask uploadTask = ref.put(_pp);
    // final Uri downloadUrl = (await uploadTask.future).downloadUrl;
    // print(downloadUrl);




    _saveState = false;
    notifyListeners();
  }
}