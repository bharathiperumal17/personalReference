import 'package:flutter/material.dart';

class CornerButton extends StatefulWidget {
  const CornerButton({super.key});

  @override
  _CornerButtonState createState() => _CornerButtonState();
}

class _CornerButtonState extends State<CornerButton> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Corner Button'),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showMenu = !_showMenu;
          });
        },
        
        child: _showMenu? const Icon(Icons.cancel_outlined):const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _showMenu ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                     const SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(50),color: Colors.purple.shade200),
                      child: IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () {},
                      ),
                    ),
                     const SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(50),color: Colors.purple.shade200),
                      child: IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {},
                      ),
                    ),
                   const SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(borderRadius:BorderRadius.circular(50),color: Colors.purple.shade200),
                      child: IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {},
                      ),
                    ),
                     const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
