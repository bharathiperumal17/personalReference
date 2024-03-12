
// import 'package:cornerbutton/custombutton.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp( const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home:  AnimatedcornerButton(),
//       // home:  CornerButton(),
//       // home: DelayButton(),
//       // home:HalfCircleButtonList(),
//       home:CustomButtonLayout()
//     );
//   }
// }


/* import 'package:flutter/material.dart';

class CircularScrollPhysics extends ScrollPhysics {
  const CircularScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CircularScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CircularScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final tolerance = this.tolerance;
    if ((velocity.abs() < tolerance.velocity) ||
        (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent)) {
      return null;
    }
    return _CircularSimulation(
      position: position,
      velocity: velocity,
      tolerance: tolerance,
    );
  }
}

class _CircularSimulation extends Simulation {
  final ScrollMetrics position;
  final double velocity;
  final Tolerance tolerance;

  _CircularSimulation({
    required this.position,
    required this.velocity,
    required this.tolerance,
  });

  @override
  double x(double time) {
    if (!isDone(time)) {
      final delta = velocity * time;
      return position.pixels + delta;
    }
    return position.pixels;
  }

  bool isDone(double time) {
    return (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent);
  }
  
  @override
  double dx(double time) {
    // TODO: implement dx
    throw UnimplementedError();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SizedBox(
          height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: CircularScrollPhysics(),
            child: Row(
              children: List.generate(
                30,
                (index) => Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text("$index", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 */


import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeModeKey = 'themeMode';

  ThemeMode themeModeValue = ThemeMode.system;

  ThemeProvider() {
    _loadThemeMode();
  }

  bool get isDarkMode => themeModeValue == ThemeMode.dark;

  void switchThemeData(bool isOn) {
    themeModeValue = isOn ? ThemeMode.light : ThemeMode.dark;
    _saveThemeMode(themeModeValue);
    notifyListeners();
  }

  void switchToSystemTheme() {
    themeModeValue = ThemeMode.system;
    _saveThemeMode(themeModeValue);
    notifyListeners();
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, themeMode.index);
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeModeIndex = prefs.getInt(_themeModeKey);
    if (themeModeIndex != null) {
      themeModeValue = ThemeMode.values[themeModeIndex];
      notifyListeners();
    } else {
      Brightness platformBrightness =
          SchedulerBinding.instance!.platformDispatcher.platformBrightness;
      themeModeValue = platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
      notifyListeners();
    }
  }
}

class ThemeDataClass {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey.shade700,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade800,
      background: const Color.fromRGBO(85, 85, 85, 1),
      inversePrimary: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade800,
      background: Colors.white54,
      inversePrimary: const Color.fromRGBO(27, 27, 27, 1),
    ),
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: context.watch<ThemeProvider>().themeModeValue,
            theme: ThemeDataClass.lightTheme,
            darkTheme: ThemeDataClass.darkTheme,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Toggling Example'),
      ),
      body: Center(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            bool isDarkTheme = themeProvider.themeModeValue == ThemeMode.light;
            return Switch(
              value: isDarkTheme,
              onChanged: (value) {
                themeProvider.switchThemeData(value);
              },
            );
          },
        ),
      ),
    );
  }
}
