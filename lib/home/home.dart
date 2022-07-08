
import 'dart:ui';
import 'package:barber_nx/barber_profile/bp_external.dart';
import 'package:barber_nx/services/auth.dart';
import 'package:barber_nx/shared/change_notifiers/profile_info.dart';
import 'package:barber_nx/user_profile/up_external.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart' as provider;

import '../services/database.dart';
import '../shared/change_notifiers/bshop_info.dart';
import '../shared/constants.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width*0.6,
          color: Colors.white,
          child: Column(
            children: [
              TextButton(onPressed: (){
                AuthService.signOut();
              }, child: const Text('Log out'))
            ],
          ),
        ),
      ),

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),


        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,

                MaterialPageRoute(
                    builder: (context) => UPExternal()),
              );
            },
            child: Hero(
              tag: 'pp',
              child: Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(right: 30),
                width: 60,
                height: 60,

                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Image.asset('assets/images/pp_1.jpg', fit: BoxFit.cover,)),
              ),
            ),
          )
        ],
      ),

      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: mainPadding.copyWith(top: 10, bottom: 10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.black.withOpacity(0.05)
                        ),

                        height: 60,

                        child: Row(
                          children: const [
                            Icon(Icons.search, size: 30,),


                            SizedBox(width: 10,),
                            Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                    const SizedBox(
                      width: 20,
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      width: 60,
                      height: 60,


                      child: const Icon(Icons.filter_list, color: Colors.white, size: 30,),
                    )
                  ],
                ),

                const SizedBox(height: 30,),


                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      const Text(
                        'Popular',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      const SizedBox(height: 20,),

                      StreamBuilder(
                        stream: Database.bShop.limit(5).snapshots(),

                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.active){

                            if(snapshot.data == null){
                              return const Center(
                                child: Text(
                                    'Oops! Something went wrong'
                                ),
                              );
                            }

                            var mid = snapshot.data as QuerySnapshot;

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,

                              child: Row(
                                children: mid.docs.map(
                                        (e){
                                          var images = e.get('images') as List;
                                          String imageURL = images.isEmpty?
                                          'https://st2.depositphotos.com/1472772/7360/i/450/depositphotos_73609873-stock-photo-miniature-barbershop.jpg':
                                          images[0];


                                          String name = e.get('name');
                                          double price = e.get('base')/1;

                                  return Container(
                                    margin: const EdgeInsets.only(right: 30),

                                    width: 200,
                                    height: 300,

                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                    ),

                                    child: GestureDetector(

                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => provider.ChangeNotifierProvider(
                                                  create: (_)=>BShopInfo(e),
                                                  child: const BPExternal())),
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                child: Image.network(imageURL, fit: BoxFit.cover,)),
                                          ),


                                          Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),


                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: BackdropFilter(
                                                  filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                  child:  Container(

                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                      width: double.infinity,

                                                      decoration:  BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20.0),
                                                          color: Colors.grey.shade200.withOpacity(0.5)),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            name,
                                                            style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),

                                                          const SizedBox(height: 10,),
                                                          Text(
                                                            '\u{20B9}$price/hr',
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              padding : const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(const Radius.circular(20)),
                                                color: Colors.white.withOpacity(0.5),
                                              ),

                                              child: const Icon(Icons.favorite, color: Colors.white, size: 30,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList()
                              ),
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );








                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      const Text(
                        'Nearby',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      const SizedBox(height: 20,),

                      StreamBuilder(
                        stream: Database.bShop.limit(5).snapshots(),

                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.active){

                            if(snapshot.data == null){
                              return const Center(
                                child: Text(
                                    'Oops! Something went wrong'
                                ),
                              );
                            }

                            var mid = snapshot.data as QuerySnapshot;

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,

                              child: Row(
                                  children: mid.docs.map(
                                          (e){
                                        var images = e.get('images') as List;
                                        String imageURL = images.isEmpty?
                                        'https://st2.depositphotos.com/1472772/7360/i/450/depositphotos_73609873-stock-photo-miniature-barbershop.jpg':
                                        images[0];


                                        String name = e.get('name');
                                        double price = e.get('base')/1;

                                        return Container(
                                          margin: const EdgeInsets.only(right: 30),

                                          width: 200,
                                          height: 300,

                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(30)),
                                          ),

                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                    child: Image.network(imageURL, fit: BoxFit.cover,)),
                                              ),


                                              Container(
                                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),


                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child: BackdropFilter(
                                                      filter:  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                      child:  Container(

                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                          width: double.infinity,

                                                          decoration:  BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20.0),
                                                              color: Colors.grey.shade200.withOpacity(0.5)),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                name,
                                                                style: const TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),

                                                              const SizedBox(height: 10,),
                                                              Text(
                                                                '\u{20B9}$price/hr',
                                                                style: const TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                  padding : const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(const Radius.circular(20)),
                                                    color: Colors.white.withOpacity(0.5),
                                                  ),

                                                  child: const Icon(Icons.favorite, color: Colors.white, size: 30,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList()
                              ),
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );



                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
