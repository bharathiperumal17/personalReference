import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ListToPage extends StatefulWidget {
  const ListToPage({super.key});

  @override
  State<ListToPage> createState() => _ListToPageState();
}

class _ListToPageState extends State<ListToPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Transform'),
        bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 40),
            child: Text(
              'List item to detail page',
              style: TextStyle(fontSize: 20),
            )),
      ),
      body: ListView.builder(
        itemCount: image.length,
        itemBuilder: (context, index) {
          return OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            closedBuilder: (context, action) {
              return ListTile(
                onTap: action,
                leading: Image.asset(image[index]),
                title: Text(people[index]['name']!),
                subtitle: Text(people[index]['job']!),
              );
            },
            openBuilder: (context, action) {
              return Scaffold(
                body: Column(
                  children: [
                    Image.asset(image[index]),
                    Text(people[index]['name']!),
                    Text(people[index]['job']!),
                  ],
                ),
              );
            },
          );
        },
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
