import 'package:first_project/bulls_and_cows.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {


  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  BullAndCows game = BullAndCows();
  final myController = TextEditingController();
  String? textInfo;
  String buttonText = 'Розпочати гру';





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.blueGrey,
      body: _mainBody(),
    );
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
    textInfo ??= game.infoText();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          const SizedBox(height: 100,),

          Text(
            textInfo!,
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
              game.gamePlay(myController);
              setState(() {
                buttonText = game.activeButtonText;
                textInfo = game.infoText();
              });
            },
            child: Text(
              buttonText,
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
