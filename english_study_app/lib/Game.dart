import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:translator/translator.dart';
import 'dart:ui';
import 'dart:async';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Matching Game",
      home: MatchGame(),
      );
  }
}

class MatchGame extends StatefulWidget {
  const MatchGame({ Key? key }) : super(key: key);

  @override
  State<MatchGame> createState() => _MatchGameState();
}

class _MatchGameState extends State<MatchGame> {
  //crete list contain eng words
  List<ItemModel> items1=[ItemModel(name: "", id: 0)];
  List<ItemModel> items2=[ItemModel(name: "", id: 0)];
  List<String> listWordEng = [""];

  // do with google translate
  GoogleTranslator translator= GoogleTranslator();

  int? score;
  bool? gameOver;

  //Timer
  static const maxSeconds = 100;
  int seconds = maxSeconds;
  Timer? time;
  void startTimer(){
    time=Timer.periodic(Duration(seconds: 1), (timer) { 
      if(seconds >0){
        setState(() {
          seconds--;
          
        }); 
      }
      else{
        time?.cancel();
        setState(() {
          items1.clear();
          items2.clear();
        });
      }
    });
        
  }      


  
  @override
  void initState() {
    super.initState();
    initGame();
  }
  void createRandomWord() {
    nouns.take(10000).forEach((element) {
      listWordEng.add(element.toString());
    });
    listWordEng.removeAt(0);
    listWordEng.shuffle();
    for(int i=0;i<5;i++){
      items1.add(ItemModel(name: listWordEng[i], id: i+1));
      translator.translate(listWordEng[i], to: "vi").then((value) {
        setState(() {
          items2.add(ItemModel(name: value.toString(), id: i+1));
        });
      });
    }
    
  }


  void initGame(){
    gameOver=false;
    score=0;
    createRandomWord();
    items1.removeAt(0);
    items2.removeAt(0);
    items1.shuffle();
    items2.shuffle();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if(items1.isEmpty) {
      gameOver = true;
      time!.cancel();
    }
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Game Matching'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:  <Widget>[
            Text.rich(TextSpan(
              children:  [
                const TextSpan(text: "Score: ", 
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
                TextSpan(
                  text: "$score",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                  ),
                )
              ]
            )             
            ),
            const SizedBox(
              height: 50,
            ) ,
            buildTimer(),
            const SizedBox(
              height: 50,
            ) ,
              if(!gameOver!)
              Row(
                children: <Widget>[
                  Column(
                    children: items1.map((item) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Draggable<ItemModel>(
                          data: item,
                          child: Container(
                            width: 200,
                            height: 50,  
                            color: Colors.amber,                        
                            child: Center(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,

                                ),
                                ),
                            ),
                          ),
                          feedback: Container(
                            width: 200,
                            height: 50,
                            color: Colors.amber,
                            child: Center(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                ),
                            ),
                          ),
                        ),
                        childWhenDragging: Container(
                           width: 200,
                           height: 50,                           
                           color: Colors.white,
                           child: const Text(""),                          
                        ),
                        
                        )  
                      );
                    }).toList()
                  ),
                  const Spacer(

                  ),
                  Column(
                    children: items2.map((item) {
                      return Container(
                        child: DragTarget<ItemModel>(
                          builder: (context, candidateData, rejectedData) => Container(
                            height: 50,
                            width: 200,
                            margin: const EdgeInsets.all(8.0),
                            color: item.accepting?Colors.red:Colors.green,
                            alignment: Alignment.center,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              
                            ),
                          ),
                        ),
                        onWillAccept: (receivedItem) {
                          setState(() {
                            item.accepting=true;
                          });
                          return true;
                        },
                        onAccept: (receivedItem){
                          if(item.id==receivedItem.id){
                            setState(() {
                              score = score! + 10;
                              items1.remove(receivedItem);
                              items2.remove(item);
                              item.accepting=false;
                            });
                          }
                          else{
                            setState(() {
                              score = score! - 5;
                              item.accepting=false;
                            });
                          }
                        },
                        onLeave: (receivedItem){
                          setState(() {
                            item.accepting=false;
                          });
                        },
                        ),
                      );
                        
                      
                    }).toList(),
                  ),

                ]
              ),
            const SizedBox(
              height: 50,
            ),
            
            if(gameOver!)
            Center(
              
              child: TextButton(
                style: ButtonStyle(                  
                  foregroundColor: MaterialStateProperty.all(Colors.blue),
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () => {
                  setState(() {   
                    items1.add(ItemModel(name: "", id: 0)); 
                    items2.add(ItemModel(name: "", id: 0));   
                    seconds=maxSeconds;             
                  }),
                  initGame()
                  
                },
                child: const Text("Continue"),
              ),
            ),        
          ]
        )
      )          
    );            
  }

  Widget buildTime() {
    return Text(
    "$seconds",
    style: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    )
  );
  }

  Widget buildTimer() => SizedBox(
    width: 100,
    height: 100,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value:1- seconds/maxSeconds,
          valueColor: const AlwaysStoppedAnimation(Colors.white),
          strokeWidth: 6,
          backgroundColor: Colors.greenAccent,
        ),
        Center(child: buildTime(),)
      ],
    ),
  );

  
}


class ItemModel{
  final String name;
  final int id;
  bool accepting;
  ItemModel({required this.name ,required this.id, this.accepting=false});
}


