import 'package:flutter/material.dart';
import 'package:fonttheme/homepage.dart';
import 'package:fonttheme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [ChangeNotifierProvider(create:(context) => ThemeProvider(),)],
      child:const AppWithTheme() 
    );
  }
}

class AppWithTheme extends StatelessWidget {
  const AppWithTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider= context.read<ThemeProvider>();
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode:themeProvider.themeModeValue,
        theme: ThemeDataClass.lightTheme,
        darkTheme: ThemeDataClass.darkTheme,
        home: const MyHomePage(),
      );
  }
}