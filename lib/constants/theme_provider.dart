import 'package:flutter/material.dart';
import 'package:one_space/constants/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.dark;
  Color selectedPrimaryColor = AppColors.primaryColors[0];

  setSelectedThemeMode(ThemeMode themeMode) {
    selectedThemeMode = themeMode;
    notifyListeners();
  }

  setSelectedPrimaryColor(Color color) {
    selectedPrimaryColor = color;
    notifyListeners();
  }
}
