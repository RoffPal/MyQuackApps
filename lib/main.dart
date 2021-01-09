import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quack_apps/state_capital/state_capital.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'brain_rack/brain_rack_main_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppHome(),
    );
  }
}

//Serves as home page to the app.......holds the list of quack games in a list view
class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();

}

class _AppHomeState extends State<AppHome> {
  List<StatefulWidget> games = [BrainRack(),QuizApp()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Platform.localeName),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: games.length,
        itemBuilder: (context, index) => GameTile(games[index]), separatorBuilder: (context, index) => SizedBox(height: 10,),),
    );
  }


  // Tile for individual list of Games in the list games of AppHome class
  Widget GameTile(StatefulWidget game){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => game));
      },
      child: Card(
        elevation: 3.3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.5),
                child: Image.asset("asset/images/itunu.jpg",
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,),
              ),
              Divider(
                color: Colors.black45,
              ),
              Text(game.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.blueAccent), ),
            ],
          ),
        ),
      ),
    );
  }
}

