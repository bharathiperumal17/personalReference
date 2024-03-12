import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggletheme/provider.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  @override
  Widget build(BuildContext context) {
    bool switchValue =
        Provider.of<ThemeProvider>(context).themeModeValue == ThemeMode.light;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: switchValue,
            onChanged: (value) {
              
              Provider.of<ThemeProvider>(context, listen: false)
                  .switchThemeData(value);
                  
            },
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('pop button'),
        ),
      ),
    );
  }
}
