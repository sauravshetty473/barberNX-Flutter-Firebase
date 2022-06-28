import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';


class UniversalTimer with ChangeNotifier{
  Timer? _timer;
  var mid = List.generate(16, (index) => index);
  bool resetStatus = true;
  var fadeDuration =const Duration(milliseconds: 500);        //set the fade duration here
  var tickDuration =const Duration(milliseconds: 500);         // set the duration between each fade here

  void work(){              // logic for switching between pause and play states
    resetStatus?play():reset();
  }

  void play(){            // function to start the animation
    resetStatus = false;        //changing the reset status to false
    notifyListeners();         // notifying the listener, in this case the pause/play button will change
    mid = List.generate(16, (index) => index);      // generating a new list
    _timer = Timer.periodic(          // initialising the timer
        tickDuration,
            (timer) {       // timer function, goes off after each tick duration
          if(mid.isEmpty){     // if the list is empty(or the animation is complete)
            timer.cancel();
            return;
          }
          mid.removeAt(Random().nextInt(mid.length));   // randomly removing blocks
          notifyListeners();        // notifying the listeners, with the latest list information
        }
    );
  }

  void reset(){         // function to reset the animation
    resetStatus = true;
    if(_timer == null) return;
    _timer?.cancel();
    mid = List.generate(16, (index) => index);
    notifyListeners();     // notifying listeners about the fresh list(mid)
  }
}