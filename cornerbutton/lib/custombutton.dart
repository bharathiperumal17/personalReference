import 'package:flutter/material.dart';

class CustomButtonLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Layout')),
      floatingActionButton: FloatingActionButton(onPressed: (){}),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 1 - 70,
            top: MediaQuery.of(context).size.height / 1.5 - 150,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.music_note, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 1 -  120,
            top: MediaQuery.of(context).size.height / 2 +90,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.rocket, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 1 - 150,
            top: MediaQuery.of(context).size.height / 2 + 200,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
