import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';


int time = 12;



class BrainRack extends StatefulWidget {
  @override
  _BrainRackState createState() => _BrainRackState();
}

class _BrainRackState extends State<BrainRack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Clock(),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: AvatarGlow(child: FloatingActionButton.extended(onPressed: null, label: null)),
    );
  }
}




// Timer to reupdate only its own widget when it ticks
class Clock extends StatefulWidget {
  _ClockState clockState = new _ClockState();
  Timer timer;

  Clock(){
    timer = Timer.periodic(Duration(seconds: 1), clockState.update);
  }

  @override
  _ClockState createState() => clockState;
}

class _ClockState extends State<Clock> {

  void update(Timer timer){
    setState(() {
      time--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return         Text(time.toString());

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Icon(Icons.timer_outlined),
    //     Text(time.toString())
    //   ],
    // );
  }
}


