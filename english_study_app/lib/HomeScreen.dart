import 'package:flutter/material.dart';
import 'package:translator/translator.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  final translator = GoogleTranslator();

  _translateLang ()
  {
    if (fromController.toString().isNotEmpty){
    translator.translate(fromController.text, from: 'en',to: 'vi').then((result){
      setState(() {
        toController.text=result.toString();
      });
    });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
           Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: fromController,
              decoration: const InputDecoration(hintText: 'Enter Text for translate'),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              readOnly: true,
              controller: toController,
              decoration:const InputDecoration(hintText: 'translated Text'),
            ),
          ),
           Center(
              child: TextButton(
                child:const Text('Translate'),
                onPressed: _translateLang,
              ),
            )
        ]
        )
    );
  }
}
