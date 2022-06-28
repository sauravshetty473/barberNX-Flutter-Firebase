import 'package:barber_nx/shared/constants.dart';
import 'package:barber_nx/user_profile/up_internal.dart';
import 'package:flutter/material.dart';

class UPExternal extends StatelessWidget {
  const UPExternal({Key? key}) : super(key: key);

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

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UPInternal()),
                  );
                },
                  child: const Icon(Icons.edit_rounded)))
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: mainPadding.copyWith(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Hero(
                    tag: 'pp',
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: 200,
                      height: 200,

                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                          child: Image.asset('assets/images/pp_1.jpg', fit: BoxFit.cover,)),
                    ),
                  ),


                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Saurav Shetty',
                    textAlign: TextAlign.center,
                    style: FontSize.title,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'Joined on 25 March',
                    textAlign: TextAlign.center,
                    style: FontSize.text,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
