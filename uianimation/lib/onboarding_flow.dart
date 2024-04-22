import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:uianimation/card_to_page.dart';

class OnBoardingFlow extends StatefulWidget {
  const OnBoardingFlow({Key? key}) : super(key: key);

  @override
  State<OnBoardingFlow> createState() => _OnBoardingFlowState();
}

class _OnBoardingFlowState extends State<OnBoardingFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Axis Transition'),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 40),
          child: Text(
            'Onboarding to Next Screen',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: CircleAvatar(
              radius: 150,
              child: Image.asset('assets/images/baby.png'),
            ),
          ),
          const Text(
            '''Contrary to popular belief, Lorem Ipsum is not simply random text. 
              It has roots in a piece of classical Latin literature from 45 BC, 
              making it over 2000 years old. Richard McClintock, a Latin professor
               at Hampden-Sydney College in Virginia, looked up one of the more
                obscure Latin words, consectetur...''',
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const CardToPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          child: child,
        );
      },
    ));
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

}


