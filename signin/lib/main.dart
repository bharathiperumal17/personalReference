import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin/firebase_options.dart';
import 'package:signin/functions.dart';
import 'package:signin/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FireBaseFunctions(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor:const Color.fromARGB(255, 113, 235, 235)),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

