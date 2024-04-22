import 'package:demoflattrade/screens/watchList_files/watchlist_data_provider.dart';
import 'package:demoflattrade/screens/watchList_files/watchlist_screen.dart';
import 'package:demoflattrade/websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WatchListProvider(context: context),
        ),
        ChangeNotifierProvider(create: (context) => WebSocketProviderFlattradeUI(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flattrade',
        theme: ThemeData(textTheme: GoogleFonts.plusJakartaSansTextTheme()),
        home: const WatchListScreen(),
      ),
    );
  }
}
