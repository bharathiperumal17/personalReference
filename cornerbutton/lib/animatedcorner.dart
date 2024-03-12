import 'package:cornerbutton/fabcontroller.dart';
import 'package:flutter/material.dart';

class AnimatedcornerButton extends StatefulWidget {
  const AnimatedcornerButton({super.key});

  @override
  State<AnimatedcornerButton> createState() => _AnimatedcornerButtonState();
}

class _AnimatedcornerButtonState extends State<AnimatedcornerButton> {
  Color _backgroundcolor=Colors.white;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title:const Text('AnimatedCircular Menu'),),
      backgroundColor: _backgroundcolor,
        floatingActionButton: FabCircularMenu(
          // ringDiameter: 300,
        //  ringColor: Colors.pink,
        //  fabCloseColor: Colors.yellow,
        //  fabOpenColor:Colors.purple ,

          children: <Widget>[
            IconButton(icon: const Icon(Icons.home,color: Colors.black26,), onPressed: () {
            setState(() {
              _backgroundcolor=Colors.black26;
            });
            }),
            IconButton(icon:  Icon(Icons.favorite,color: Colors.amber.shade200,), onPressed: () {
              setState(() {
              _backgroundcolor=Colors.amber.shade200;
            });
            }),
             IconButton(icon:  Icon(Icons.person,color: Colors.purple.shade200,), onPressed: () {
             setState(() {
              _backgroundcolor=Colors.purple.shade200;
            });
            }),
             IconButton(icon:  Icon(Icons.access_alarm,color: Colors.blue.shade200,), onPressed: () {
              setState(() {
              _backgroundcolor=Colors.blue.shade200;
            });
            })
          ]
        )
      );
  }
}

