import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

class BShopInfo with ChangeNotifier{
  late String _name;
  late List<dynamic> _images;
  late String _desc;
  late int _slot;
  late DateTime _start;
  late DateTime _end;
  late List<dynamic> _booked;
  late String _owner;
  late GeoPoint _location;
  late int _base;
  late int? _selected;
  late String mainImage;

  BShopInfo(DocumentSnapshot e){
    _name = e.get('name');
    _images = e.get('images');
    _desc = e.get('description');
    _start = e.get('start').toDate();
    _end = e.get('end').toDate();
    _slot = e.get('slot');
    _base = e.get('base');
    _location = e.get('location');
    _owner = e.get('owner');
    _selected = null;
    _booked = e.get('booked');

    mainImage = _images.isNotEmpty?images[0]:
    'https://st2.depositphotos.com/1472772/7360/i/450/depositphotos_73609873-stock-photo-miniature-barbershop.jpg';

  }

  String get name => _name;
  String get desc => _desc;
  String get owner => _owner;
  GeoPoint get location => _location;
  List<dynamic> get booked => _booked;
  List<dynamic> get images => _images;
  int get base => _base;
  int get slot => _slot;
  DateTime get start => _start;
  DateTime get end => _end;
  int? get selected => _selected;


  set changeSelected(int? index){
    _selected = index;
    notifyListeners();
  }
}