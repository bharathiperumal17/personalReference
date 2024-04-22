import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CardToPage extends StatefulWidget {
  const CardToPage({super.key});

  @override
  State<CardToPage> createState() => _CardToPageState();
}

class _CardToPageState extends State<CardToPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Transform'),
        bottom: const PreferredSize(preferredSize: Size(double.infinity, 40), child: Text('Card To Page',style: TextStyle(fontSize: 20),)),
        
      ),
      body:  GridView.builder(
        itemCount: image.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Center(
                  child: OpenContainer(
                    tappable: true,
                    transitionType: ContainerTransitionType.fadeThrough,
                    // transitionDuration:const Duration(seconds: 3),
                    openBuilder: (BuildContext context, VoidCallback _) {
          return DetailImagePage(imageUrl: image[index],index: index,);
                    },
                    closedBuilder: (BuildContext context, VoidCallback openContainer) {
                    
          return GestureDetector(
            onTap: openContainer,
            child: Hero(
              tag: image[index],
              child: Image.asset(
                image[index],
                fit: BoxFit.cover,
              ),
            ),
          );
                    },
                  ),
                );
        },
      ),
    );
  }
}


class DetailImagePage extends StatelessWidget {
  final String imageUrl;
  final int index;

  const DetailImagePage({super.key,  required this.imageUrl, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: imageUrl,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text('Name :${people[index]['name']}'),
            Text('JOB :${people[index]['job']}')
          ],
        ),
      ),
    );
  }
}


List<String> image = [
  'assets/images/baby.png',
  'assets/images/boy1.png',
  'assets/images/briliant.png',
  'assets/images/girl.png',
  'assets/images/sadgirl.png',
  'assets/images/smart.png'
];
 List<Map<String, String>> people = [
    {'name': 'Alice', 'job': 'Engineer'},
    {'name': 'Bob', 'job': 'Doctor'},
    {'name': 'Charlie', 'job': 'Teacher'},
    {'name': 'David', 'job': 'Artist'},
    {'name': 'Eve', 'job': 'Designer'},
    {'name': 'Frank', 'job': 'Developer'},
  ];
