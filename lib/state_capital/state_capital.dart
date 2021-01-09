import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();


}
class _QuizAppState extends State<QuizApp> {
  @override
  void dispose() {
    _timer.cancel();
    ansTimer.isActive ?? ansTimer.cancel;
  }
  final int TIME = 6;
  bool started = false, disableInput = true;
  Color _textColor = Colors.lightBlue.shade500, alarm_color = Colors.white;
  int time = 0, userAnswer, correctAnswer, userScore, currentGame;
  List<List> used = [];
  List<String> usedCompli = [];
  List<String> badScore = ["Olodo Oshi 🤣🤣🤣", "Ode Oshi....common State And Capital", "Na only fish eyes u sabi chop 🤣😂", "Empty Brain, ur matter don tire me 🤦‍♀", "They don sell ur brain 🙄", "run go Lafemwa, ur brain dey for sale dere 😢", "Dead Brain"];
  List<String> goodScore = ["Awwwwwn.... oyahhh Brainiac","mtcheeew na simple questions","Dash me ur brain na","Efiko!!!","U knw say na luck u take win😒","Head Boyyy!!","Efiwe!!!!!","Wale Shoyinka Pickin"];
  List<List> quesAns = [["Adamawa","Yola"],["Ekiti","Ado-Ekiti"],["Enugu","Enugu"],["Cross River","Calabar"],["Delta","Asaba"],["Ebonyi","Abakaliki"],["Edo","Benin City"],["Akwa Ibom","Uyo"],["Anambra","Awka"],["Bauchi","Bauchi"], ["Bayelsa","Yenagoa"],["Benue","Makurdi"],["Borno","Maiduguri"],
    ["Gombe","Gombe"], ["Imo","Owerri"],["Jigawa","Dutse"],["Abia","Umuahia"],["Kaduna","Kaduna"],["Kano","Kano"],["Katsina","Katsina"],["Kebbi","Birnin-Kebbi"],["Kogi","Lokoja"],
    ["Kwara","Ilorin"],["Lagos","Ikeja"],["Nasarawa","Lafia"],["Niger","Minna"],["Ogun","Abeokuta"],["Ondo","Akure"],["Osun","Oshogbo"],["Oyo","Ibadan"],["Plateau","Jos"],
    ["Rivers","Port-Harcourt"],["Sokoto","Sokoto"],["Taraba","Jalingo"],["Yobe","Damaturu"],["Zamfara","Gusau"]];
  List<Color> butColors = [Colors.white, Colors.white, Colors.white, Colors.white]; // holds colors for option buttons' background for quizzer
  List<String> butTexts = ["   ","   ","   ","   ","Long Press Anywhere On Screen To Start"]; // but represents button, last-one represents question

  Timer _timer, ansTimer;

  void chooseAnswer(int index, BuildContext context){
    if(ansTimer.isActive) return;  // prevents user from clicking two answers together and fixes the using system generated answer to ge5t points
    setState( () {
      if(!disableInput){
        _timer.cancel();
        userAnswer = index;
        for(int i = 0; i < butColors.length; i++)
          butColors[i] = i != index ? Colors.white: Colors.amber;

        void checkAnswer() {
          ansTimer = Timer(Duration(seconds: 1), () {
            disableInput = true;
            setState(() {
              butColors[correctAnswer] = Colors.lightGreen;
              Timer(Duration(seconds: 1), (){
                if(userAnswer == correctAnswer)
                  userScore++;
                reStart(context);
              });
              disableInput = false;//SetState
            });   // Timer
          });
        }

        checkAnswer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double phoneHeight = MediaQuery.of(context).size.height, phoneWidth  = MediaQuery.of(context).size.width; // holds the fixed size of the mobile screen

    return Scaffold(
      appBar: AppBar(
        title : Text("State_Capital"),
        backgroundColor: Colors.lightBlue.shade700.withOpacity(0.8),
        actions: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined, color: alarm_color,),
                Text(time.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: alarm_color)),
                SizedBox(
                  width: 10,
                )
              ]
          ),
        ],

      ),

      body: Builder(
        builder: (BuildContext context) => InkWell(
          onLongPress: () {
            disableInput = false;
            if (!started)
              reStart(context);
            started = true;
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(userScore != null ? "Score: $userScore": "" , style: TextStyle(color: Colors.lightBlue.shade700, fontSize: 20)),
                          Text(currentGame != null ?"$currentGame / 10": "", style: TextStyle(color: Colors.lightBlue.shade700, fontSize: 20))
                        ]
                    ),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Container(
                          alignment: Alignment.center,
                          height: phoneHeight * 0.5,
                          decoration: BoxDecoration(
                            color: _textColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Text(butTexts[4], style: TextStyle(fontSize: 20, color: Colors.grey.shade700), textAlign: TextAlign.center,))
                      ),
                    ),
                    Card(
                      elevation: 10.5,
                      margin: EdgeInsets.only(top: phoneHeight * 0.05),
                      shadowColor: _textColor.withOpacity(0.45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                              children: [
                                Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => chooseAnswer(0, context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 5),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: butColors[0],
                                                border: Border.all(width: 0.9, style: BorderStyle.solid, color: Colors.grey.shade400),
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Text(butTexts[0], textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, color: _textColor),maxLines: 1, overflow: TextOverflow.ellipsis,),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: InkWell(
                                          onTap: () => chooseAnswer(1, context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 5),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: butColors[1],
                                                border: Border.all(width: 0.9, style: BorderStyle.solid, color: Colors.grey.shade400),
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Text(butTexts[1], textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, color: _textColor),maxLines: 1, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                                Divider(thickness: 0.9,),
                                Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () => chooseAnswer(2, context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(right: 5),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: butColors[2],
                                                border: Border.all(width: 0.9, style: BorderStyle.solid, color: Colors.grey.shade400),
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Text(butTexts[2], textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, color: _textColor),maxLines: 1, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: InkWell(
                                          onTap: () => chooseAnswer(3, context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 5),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: butColors[3],
                                                border: Border.all(width: 0.9, style: BorderStyle.solid, color: Colors.grey.shade400),
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Text(butTexts[3], textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold, color: _textColor),maxLines: 1, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                    ]
                                )
                              ]
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }


  void reStart(BuildContext context){
    if(!started){
      userScore = 0;
      currentGame = 0;
    }
    currentGame++;
    time = TIME;
    butColors = [Colors.white, Colors.white, Colors.white, Colors.white]; // holds colors for option buttons' background for quizzer
    alarm_color = Colors.white;
    setState(() {
      Random rand = Random();

      int r = 0;
      do{
        r = rand.nextInt(quesAns.length);
        if(used.length == quesAns.length)
          break;     // prevents app from searching for what it  can't find
      }while(used.contains(quesAns[r]));
      used.add(quesAns[r]);

      butTexts[4] = "Capital of ${quesAns[r][0]}?";
      int a = rand.nextInt(4);
      correctAnswer = a;
      var list = [r];
      for(int i = 0; i < 4; i++)
        butTexts[i] = "${i != a ? quesAns[rando(list)][1]: quesAns[r][1]}";


      if(_timer != null)
        _timer.cancel();
      if(ansTimer != null && ansTimer.isActive)
        ansTimer.cancel();

      _timer = Timer.periodic(new Duration(seconds: 1), (_timer) {
        setState(() {
          --time;
          if(time < 4)
            alarm_color = Colors.red;
          if(time == -1){
            used.removeLast();
            reStart(context);
          }
        });
      });

      if(currentGame == 11 || used.length == quesAns.length){
        currentGame = 10;
        time = 0;
        butColors = [Colors.white, Colors.white, Colors.white, Colors.white]; // holds colors for option buttons' background for quizzer
        butTexts = used.length != quesAns.length ? ["   ","   ","   ","   ","Long Press Screen To Continue"] : ["","","","","","Congrats!....You Finished The whole questions"];
        started = used.length == quesAns ? true : false;
        disableInput = true;
        _timer.cancel();

        String compliment(List list){
          int r;
          do{
            r = Random().nextInt(list.length);
          }while(usedCompli.contains(list[r]));
          usedCompli.add(list[r]);
          return list[r];
        }
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(userScore > 7 ? compliment(goodScore) : compliment(badScore), style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
          backgroundColor: userScore > 8 ? Colors.green.shade500 : Colors.red.shade500,
        ));

        userScore = null;
        currentGame = null;
      }
    });
  }

  int rando(List list){

    var r;
    do{
      r = Random().nextInt(quesAns.length);
    } while(list.contains(r));
    list.add(r);
    return r;
  }

}