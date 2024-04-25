import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeModeKey = 'themeMode';
  double adjustedSmallFontSize = 14.0;
  double adjustedMediumFontSize = 16.0;
  double adjustedLargeFontSize = 20.0;
  double fontSizeDelta = 0.0;

  Future<void> _loadFontSizeDelta() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFontSizeDelta = prefs.getDouble('fontSizeDelta') ?? 0.0;
    adjustedSmallFontSize = prefs.getDouble('adjustedSmallFontSize') ?? 14.0;
    adjustedMediumFontSize = prefs.getDouble('adjustedMediumFontSize') ?? 16.0;
    adjustedLargeFontSize = prefs.getDouble('adjustedLargeFontSize') ?? 20.0;

    fontSizeDelta = savedFontSizeDelta;
    notifyListeners();
  }

  Future<void> saveFontSizeDelta(double newFontSizeDelta) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSizeDelta', newFontSizeDelta);
    await prefs.setDouble('adjustedSmallFontSize', adjustedSmallFontSize);
    await prefs.setDouble('adjustedMediumFontSize', adjustedMediumFontSize);
    await prefs.setDouble('adjustedLargeFontSize', adjustedLargeFontSize);
    notifyListeners();
  }

  void updateSmallFontSize(double newFontSize) {
    adjustedSmallFontSize = newFontSize;
    notifyListeners();
  }

  void updateMediumFontSize(double newFontSize) {
    adjustedMediumFontSize = newFontSize;
    notifyListeners();
  }

  void updateLargeFontSize(double newFontSize) {
    adjustedLargeFontSize = newFontSize;
    notifyListeners();
  }

  ThemeMode themeModeValue = ThemeMode.system;

  ThemeProvider() {
    _loadThemeMode();
    _loadFontSizeDelta();
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
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      themeModeValue = platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
      notifyListeners();
    }
  }
}

class ThemeDataClass {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade600,
      onPrimaryContainer: Colors.blue.shade900,
    ),
    textTheme: const TextTheme(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      background: Colors.white70,
      onPrimaryContainer: Colors.black,
    ),
    textTheme: const TextTheme(
        bodySmall: TextStyle(
          fontStyle: FontStyle.italic,
        ),
        bodyMedium:
            TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
        )),
  );
}
