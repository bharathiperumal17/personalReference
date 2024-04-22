

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:uianimation/card_to_page.dart';
import 'package:uianimation/list_to_page.dart';
import 'package:uianimation/onboarding_flow.dart';

class BottomNavigationFadeThrough extends StatefulWidget {
  const BottomNavigationFadeThrough({super.key});

  @override
  State<BottomNavigationFadeThrough> createState() => _BottomNavigationFadeThroughState();
}

class _BottomNavigationFadeThroughState extends State<BottomNavigationFadeThrough> {
  int _selectedIndex = 0;

  static List<Widget> widgetOptions = <Widget>[
   const CardToPage(),
   const ListToPage(),
   const OnBoardingFlow()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Through'),
       
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 40),
          child: Text('Fade Through Transition', style: TextStyle(fontSize: 20)),
        ),
      ),
      // body: AnimatedSwitcher(
      //   duration: const Duration(seconds: 5),
      //   child: widgetOptions.elementAt(_selectedIndex),
      //   transitionBuilder: (child, animation) {
      //     return FadeTransition(
      //       opacity: animation,
      //       child: child,
      //     );
      //   },
      // ),

      body: PageTransitionSwitcher(
        duration: const Duration(seconds: 5),
       transitionBuilder: (
         Widget child,
         Animation<double> primaryAnimation,
         Animation<double> secondaryAnimation,
       ) {
         return FadeThroughTransition(
           animation: primaryAnimation,
           secondaryAnimation: secondaryAnimation,
           child: child,
         );
       },
       child: Container(
         key: ValueKey<int>(_selectedIndex),
         child: widgetOptions.elementAt(_selectedIndex),
       ),
     ),
     
     bottomNavigationBar: BottomNavigationBar(
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.card_membership_outlined),
      label: 'card',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'list',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bolt),
      label: 'onboarding',
    )
  ],
  currentIndex: _selectedIndex,
  onTap: _onItemTapped,
),

    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:uianimation/card_to_page.dart';
// import 'package:uianimation/list_to_page.dart';
// import 'package:uianimation/onboarding_flow.dart';

// class BottomNavigationFadeThrough extends StatefulWidget {
//  const BottomNavigationFadeThrough({super.key});

//   @override
//   State<BottomNavigationFadeThrough> createState() => _BottomNavigationFadeThroughState();
// }

// class _BottomNavigationFadeThroughState extends State<BottomNavigationFadeThrough> {
//   int _selectedIndex = 0;
//   bool _isRefreshing = false;

//   static List<Widget> widgetOptions = <Widget>[
//     const CardToPage(),
//     const ListToPage(),
//     const OnBoardingFlow(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Future<void> _refreshPage(int index) async {
//     setState(() {
//       _isRefreshing = true;
//     });
    
//     await Future.delayed(const Duration(milliseconds: 500)); // Simulating network delay

//     setState(() {
//       _isRefreshing = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fade Through'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _refreshPage(_selectedIndex);
//             },
//             icon:const  Icon(Icons.refresh),
//           ),
//         ],
//         bottom: const PreferredSize(
//           preferredSize: Size(double.infinity, 40),
//           child: Text('Fade Through Transition', style: TextStyle(fontSize: 20)),
//         ),
//       ),
//       body: AnimatedSwitcher(
//         duration:const  Duration(milliseconds: 500),
//         child: _isRefreshing
//             ? Container(
//                 key: ValueKey<bool>(_isRefreshing),
//                 color: Colors.white, // Set your background color
//                 child:const  Center(
//                   child: CircularProgressIndicator(), // Show any loading indicator here
//                 ),
//               )
//             : FadeTransition(
//                 opacity:const AlwaysStoppedAnimation(1.0),
//                 child: widgetOptions.elementAt(_selectedIndex),
//               ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.card_membership_outlined),
//             label: 'card',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'list',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bolt),
//             label: 'onboarding',
//           )
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
