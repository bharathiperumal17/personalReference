import 'package:flutter/material.dart';
import 'package:fonttheme/font_slider.dart';
import 'package:fonttheme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Font Theme'),
        centerTitle: true,
        leading: IconButton(
          onPressed: openDrawer,
          icon: const Icon(Icons.menu_open_outlined),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('font'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FontSlider(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding:const  EdgeInsets.all(20.0),
        child:  ListView(children: [
          Text('''Overview''', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: Provider.of<ThemeProvider>(context).adjustedLargeFontSize,
              ),),
          Text('''Slider in Flutter is a highly interactive UI widget that allows users to choose a single value from a set of options. It has a lot of features, such as numeric and date values, labels, ticks, dividers, and a tooltip. It is an input widget that allows us to specify a range of values by dragging or pushing on the desired spot. This tutorial will demonstrate how to utilise the slider widget in Flutter to specify the range of values and customise the appearance of a slider.
        ''',
         style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: Provider.of<ThemeProvider>(context).adjustedSmallFontSize,
              ),
        ),
          Text('''Introduction''',
           style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: Provider.of<ThemeProvider>(context).adjustedMediumFontSize,
              ),
          ),
          Text('''A slider is a widget in the program that allows you to pick a value from a specific range. We may scroll through the values and choose the desired one. To implement a slider in Flutter, we do not need to install any dependencies. A slider may be used to choose a value from a set of continuous or discrete values. It employs a continuous range of numbers by default. We must supply a non-null value for divisions if we wish to use discrete values. The number of discrete intervals is shown by this discrete division. Before we can acquire the value, we must first specify the minimum and maximum values. Slider has min and max parameters for setting the minimum and maximum limits.
         ''',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: Provider.of<ThemeProvider>(context).adjustedSmallFontSize,
              ),
         ),
          ],),
      )
    );
  }
}
