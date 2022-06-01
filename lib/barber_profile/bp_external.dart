import 'package:barber_nx/shared/bshop_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class BPExternal extends StatefulWidget {
  const BPExternal({Key? key}) : super(key: key);

  @override
  State<BPExternal> createState() => _BPExternalState();
}

class _BPExternalState extends State<BPExternal> {



  double pageOffset = 0;

  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController =  ScrollController(initialScrollOffset: 0);
    _scrollController.addListener(() {
      setState(() {
        pageOffset = _scrollController.offset;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    final BShopInfo bShopInfo = Provider.of<BShopInfo>(context);
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [

          Image.network(bShopInfo.mainImage, height: 600*(1+pageOffset/1000), width: double.infinity, fit: BoxFit.cover,),

          SafeArea(
            child: SingleChildScrollView(

              controller: _scrollController,

              child: Container(

                margin: const EdgeInsets.only(top: 500),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.elliptical(30, 20), topLeft:  Radius.elliptical(30, 20)),
                  color: Colors.white,

                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -10),
                        blurRadius: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                      )
                    ]

                ),
                width: double.infinity,





                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      bShopInfo.name,

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50
                      ),
                    ),


                    const SizedBox(height: 20,),

                    Text(
                       bShopInfo.desc,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        color: Colors.black.withOpacity(0.55)
                      ),
                    ),


                    const SizedBox(height: 20,),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        
                        child: Image.network('https://developers.google.com/maps/images/landing/hero_geocoding_api_480.png', fit: BoxFit.cover,),
                      ),
                    ),


                    const SizedBox(height: 40,),

                    const Text(
                      'Available Slots',

                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35
                      ),
                    ),



                    GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: 3,
                      ),


                        children: ((){
                          var mid = List.generate(
                              (bShopInfo.end.difference(bShopInfo.start).inMinutes/ (15*bShopInfo.slot)).floor(),
                                  (index) => bShopInfo.start.add(Duration(minutes: bShopInfo.slot*15*index)));
                          return mid.asMap().map((key, value) {

                            var blocked = bShopInfo.booked.contains(key);
                            var selected = bShopInfo.selected == key;
                            return MapEntry(
                                key, GestureDetector(
                              onTap: blocked?null:(){

                                if(bShopInfo.selected == key){
                                  bShopInfo.changeSelected = null;
                                  return;
                                }
                                bShopInfo.changeSelected = key;
                              },
                                  child: Container(


                            decoration: !blocked?
                            BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.green, width: 1),
                                  color: selected?Colors.green:Colors.white
                            ):
                            BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(color: Colors.red, width: 1),
                                  color: Colors.red
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),

                            child: Center(
                              child: Text(
                                  value.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                    color: !blocked?Colors.black:Colors.white
                                  ),
                              ),
                            ),
                          ),
                                ));
                          }).values.toList();
                        }()),
                    ),



                    const SizedBox(
                      height: 200,
                    ),




                  ],
                ),

                
                

              ),
            ),
          ),

          SafeArea(
            child: AnimatedContainer(

              decoration:  BoxDecoration(
                  color: pageOffset>550?Colors.white: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 12,
                      color: pageOffset>550?Color.fromRGBO(0, 0, 0, 0.16): Colors.transparent
                    )
                  ]
              ),
              duration: const Duration(milliseconds: 0),
              width: double.infinity,
              height: 50,


              child: pageOffset>550?const Center(
                child: Text(
                  'Salon NX',

                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ):const SizedBox(),
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(

                decoration:  const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.16)
                      )
                    ]
                ),
                
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(
                        bShopInfo.selected==null?'No slot(s) selected':bShopInfo.start.add(Duration(minutes: 15*bShopInfo.slot*bShopInfo.selected!)).toString()
                      ),

                      const SizedBox(height: 5,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white
                            
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
