import 'package:flutter/material.dart';
import 'dart:math';

class App extends StatefulWidget {


  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final String startInfo = 'Тут буде виводитися інформація щодо биків та корів';
  final myController = TextEditingController();
  int gameStage = 0;
  String? currentInfo;
  String? currentNumber;
  String realNumber= '';
  String activeButtonText = 'Розпочати гру';

  void randGenerating(){
    setState(() {
      activeButtonText = 'Підтвердити відповідь';
      gameStage = 1;
      realNumber = '';
      var rand = Random();
      for (var i = 0; i < 4; i++) {
        int r0 = rand.nextInt(9);
        int r1 = rand.nextInt(9);
        while(r1 == r0){
          r1 = rand.nextInt(9);
        }
        int r2 = rand.nextInt(9);
        while(r2 == r0 || r2 == r1){
          r2 = rand.nextInt(9);
        }
        int r3 = rand.nextInt(9);
        while(r3 == r0 || r3 == r1 || r3 == r2){
          r3 = rand.nextInt(9);
        }
        realNumber = r0.toString() + r1.toString() + r2.toString() + r3.toString();
      }
      print(realNumber);
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.blueGrey,
      body: _mainBody(),
    );
  }

  String infoText(){
    if(currentInfo == null){
      return startInfo;
    }
    return currentInfo!;
  }

  void checking() {
    setState(() {
      if (myController
          .text
          .length != 4) {
        print('-1');
        currentInfo = "Ви маєте написити чотири унікальні цифри";
      } else {
        currentNumber = myController.text;
        bool u = true;
        for(int i = 0; i < 3; i++){
          if(currentNumber!.contains(currentNumber![i], i+1)){
            print('-2');
            currentInfo = "Ви маєте написити чотири унікальні цифри";
            u = false;
            break;
          }
        }
        if(u) {
          int bullNumber = 0;
          int cowNumber = 0;
          for (int i = 0; i < 4; i++) {
            if (realNumber[i] == currentNumber![i]) {
              bullNumber++;
            } else {
              if (realNumber.contains(currentNumber![i])) {
                cowNumber++;
              }
            }
          }
          if(bullNumber == 4){
            activeButtonText = 'Розпочати нову гру';
            currentInfo = 'ВИ ПЕРЕМОГЛИ!';
            gameStage = 2;
          } else{
            currentInfo = '$bullNumber бика та $cowNumber корів';
          }
          }
        }

    });
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Бики та корови створені \n   Артемом Салієнком',
      style: TextStyle(
        color: Colors.white
      ),
      ),
      centerTitle: true,
      backgroundColor: Colors.black38,
    );
  }

  Widget _mainBody(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(width: 20,),


            Text(
              '1',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                  color: Colors.white
              ),
            ),


            Text(
              '2',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                  color: Colors.white
              ),
            ),


            Text(
              '3',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                  color: Colors.white
              ),
            ),


            Text(
              '4',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                  color: Colors.white
              ),
            ),

                SizedBox(width: 20,),

          ]),

          const SizedBox(height: 100,),

          Text(
            infoText(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
                color: Colors.white
            ),
          ),

          const SizedBox(height: 70,),


          TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
                color: Colors.white
            ),

            controller: myController,

            decoration: const InputDecoration(
              filled: true,
                fillColor: Colors.black38,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  borderSide: BorderSide(color: Colors.white),
                ),

            ),
          ),

          const SizedBox(height: 70,),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.red;
                    }
                    return Colors.black38;
                  }),
            ),
            onPressed: () {
              if(gameStage == 0) {
                randGenerating();
              }else if(gameStage == 1){
                checking();
              }else{
                randGenerating();
              }
            },
            child: Text(
              activeButtonText,
              style: const TextStyle(fontSize: 20,
                  color: Colors.white),
            ),
          ),

          const SizedBox(height: 200,),

        ],
      ),
    );

  }
}
