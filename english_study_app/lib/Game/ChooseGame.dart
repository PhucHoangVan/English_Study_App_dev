import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'MatchingGame.dart';
class ChooseGame extends StatefulWidget {
  const ChooseGame({ Key? key }) : super(key: key);

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {

  String gifChoose="MatchingGame";
  List<String> gifList=["MatchingGame","GuessWord"];
  int i=0;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.blueAccent,     
      appBar: AppBar(
        title: const Text('Choose the game you want to practice'),
        centerTitle: true,
      ),
      body:  Center(
        child: GestureDetector(
          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MatchGame()),
              );
          },
          child: Column(
            children: <Widget>[
              buildImage(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [ 
                  Container(
                    margin: const EdgeInsets.only(left: 180.0),
                    child: IconButton(
                      iconSize: 50,                    
                      icon: const Icon(Icons.navigate_before,color: Colors.white),
                      onPressed: (){
                        if(--i < 0){
                          i=gifList.length-1;
                        }
                        setState(() {
                          gifChoose=gifList[i];
                        });
                          

                      },
                    ),
                  ),               
                  Container(
                    margin: const EdgeInsets.only(right: 0.0),
                    child: IconButton(
                      iconSize: 50,                    
                      icon: const Icon(Icons.navigate_next,color: Colors.white),
                      onPressed: (){
                        if(++i >= gifList.length){
                          i=0;
                        }
                        setState(() {
                          gifChoose=gifList[i];
                        });
                      },
                    ),
                  ),      
                ],
              )
            ],
          ),
          
        ),
      )
      
    );
  }
   Widget buildImage() => Image.asset(
    gifChoose + ".gif",
    height: 170,
    width: double.infinity,
    fit: BoxFit.cover
    );
}



 

 