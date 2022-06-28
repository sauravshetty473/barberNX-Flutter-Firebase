import 'dart:io';

import 'package:flutter/material.dart';

import '../shared/constants.dart';
import 'package:image_picker/image_picker.dart';




class UPInternal extends StatefulWidget {
  const UPInternal({Key? key}) : super(key: key);

  @override
  State<UPInternal> createState() => _UPInternalState();
}

class _UPInternalState extends State<UPInternal> {

  final _formkey = GlobalKey<FormState>();

  bool selecting = false;
  late String fname;
  late String lname;
  File? imageFile;


  @override
  void initState() {
    // take values from provider, set listen to false;
    fname = 'Saurav';
    lname = 'Shetty';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black.withOpacity(0.55)
        ),
        backgroundColor: Colors.white,
        title:  Text(
          '',
          style: TextStyle(
              color: Colors.black.withOpacity(0.55)
          ),
        ),
        centerTitle: true,
        actions:  [

          Container(
              margin: const EdgeInsets.only(right: 30),
              child: GestureDetector(
                  onTap: (){
                    bool? canSave = false;
                    if(_formkey.currentState != null){
                      canSave = _formkey.currentState?.validate()??false;
                    }

                    if(canSave){
                      // code will trigger saving function of provider
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'save ',
                        style: FontSize.text,
                      ),
                      const Icon(Icons.save)
                    ],
                  )))
        ],
      ),

      body: SafeArea(
        child: Form(

          key: _formkey,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: mainPadding.copyWith(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Hero(
                      tag: 'pp',
                      child: GestureDetector(
                        onTap: (!selecting)?() async{
                          print('hello');
                          setState(() {
                            selecting = true;
                          });
                          final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 1000, maxHeight: 1000);
                          setState(() {
                            selecting = false;
                          });
                          if(image == null){
                            return;
                          }
                          imageFile = File(image.path);
                        }:null,
                        child: Container(

                          padding: const EdgeInsets.all(0),
                          width: 200,
                          height: 200,

                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(40)),
                              child: imageFile == null?Image.asset('assets/images/pp_1.jpg', fit: BoxFit.cover,):
                                  Image.file(imageFile!, fit: BoxFit.cover,)
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      validator: (val){
                        val = val??'';
                        bool fail = val.trim().length <3;
                        if(fail){
                          return 'enter at least 3 characters';
                        }
                      },
                      initialValue: fname,
                      textAlign: TextAlign.center,
                      style: FontSize.title,
                      onChanged: (val){
                        fname = val;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      initialValue: lname,
                      textAlign: TextAlign.center,
                      style: FontSize.title,

                      validator: (val){
                        val = val??'';
                        bool fail = val.trim().length <3;
                        if(fail){
                          return 'enter at least 3 characters';
                        }
                      },

                      onChanged: (val){
                        lname = val;
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      'joined on 25 march',
                      textAlign: TextAlign.center,
                      style: FontSize.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
