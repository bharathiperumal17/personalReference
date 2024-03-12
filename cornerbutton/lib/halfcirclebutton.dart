import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HalfCircleButtonList extends StatefulWidget {
  @override
  _HalfCircleButtonListState createState() => _HalfCircleButtonListState();
}

class _HalfCircleButtonListState extends State<HalfCircleButtonList> {
  List<Widget> _buttons = [];
  bool _showButtons = false;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Half Circle Button List'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Stack(
      
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width:  double.infinity,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showButtons = !_showButtons;
                        if (_showButtons) {
                          
                          _generateButtons();
                        } 
                        else {
                          _buttons.clear();
                        }
                      });
                    },
                    child: Icon(_showButtons ? Icons.close : Icons.add),
                  ),
                ),
              ),
            ],
          ),
          ..._buttons,
        ],
      ),
      
    );
  }

  void _generateButtons() {
  if (_buttons.isNotEmpty) {
    _buttons.clear();
  } else {
     final int buttonCount = 3; // You can adjust this based on your requirement
    final double radius = 100.0; // Adjust radius as needed
    final double initialAngle = -math.pi / -2; 
    // Starts from top

    for (int i = 0; i < buttonCount; i++) {
      final double angle = initialAngle + (i * math.pi) / (buttonCount - 1);
      final double x = radius * math.cos(angle);
      final double y = radius * math.sin(angle);
      
      _buttons.add(
        Positioned(
          right: 0,
          bottom: 0,
          child: Transform.translate(
            offset: Offset(x, y),
            child: FloatingActionButton(
              onPressed: () {
               print(i);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      );
    }
  }
}
}