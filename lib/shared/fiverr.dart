import 'package:barber_nx/shared/universal_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiverrAnimation extends StatefulWidget {
  const FiverrAnimation({Key? key}) : super(key: key);

  @override
  State<FiverrAnimation> createState() => _FiverrAnimationState();
}

class _FiverrAnimationState extends State<FiverrAnimation> {
  bool reset = true;               // state of the overall animation
  var mid = List.generate(16, (index) => index);    // mid stores the list of blocks ( their indices)

  @override
  Widget build(BuildContext context) {
    final UniversalTimer timer = Provider.of<UniversalTimer>(context);      //on notify listeners() this build function will be called again

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animation'),
        centerTitle: true,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          timer.work();
        },
        child: timer.resetStatus?const Icon(Icons.play_arrow): const Icon(Icons.pause),
      ),

      body: Center(
        child: SizedBox(
                              // here you can set the size of the final animation, the output will be a square of the shape,
                              //also the grid and the image sizes, will be changed relatively
          height: 350,
          width: 350,


          child: FittedBox(      // Fitted box used to resize the inner widget, relative to the outer size
            child: SizedBox(
              width: 200,
              height: 200,
              child: GridView.builder(             // grid view builder used, instead of rows and columns
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 50,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  itemCount: 16,
                  itemBuilder: (BuildContext ctx, index) {

                    return SizedBox(
                        width: 75,
                        height: 75,
                        child: AnimatedSwitcher(        // used animated switcher to animate the images, from image, to empty sized box

                          // you can use custom animation curves, both for switch in and out
                          duration: timer.fadeDuration,

                          // index varies from 0 to 15, depends on the item count, which is 16 here
                          child: timer.mid.contains(index)?Image.asset(       // the logic for alternative switching of animation
                              'assets/images/box/row-${(index/4).floor() + 1}-column-${index%4 +1}.jpg'
                          ):const SizedBox(),
                        )
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}


//val<(3-index%4)*4 + (index/4).floor()