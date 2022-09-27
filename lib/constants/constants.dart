import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

void showDialogMsg(context, {String? title, String? message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? ''),
      content: SelectableText(message ?? ''),
      actions: <Widget>[
        MaterialButton(
          child: const Text("Close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

Color giveCategoryGetColor(String e) {
  if (e == 'home') {
    return Colors.redAccent;
  } else if (e == 'work') {
    return Colors.greenAccent.shade700;
  } else if (e == 'code') {
    return Colors.blueAccent;
  } else if (e == 'play') {
    return Colors.amberAccent.shade700;
  }
  return Colors.grey;
}

List<String> folderList = ["home", "work", "code", "play"];

List<String> imageList = [
  'pencil.png',
  'travel.png',
  'takeaway-cup.png',
  'rocket.png'
];

// PrimaryColor is of type Color
// PrimarySwatch only accepts a MaterialColor.
// We’ll create a cool function that will get a MaterialColor from a Color.
// MaterialColor is a color with a primary value (first param; int),
// and 10 shades of that color (second param; Map<int, Color>) with the int map key as the shade index

// (Important)Shade with index 500 is the primary color of that material color.
// So we needed to find a way to get darker and lighter shades of a certain color to create all the shades.

class AppColors {
  static List<Color> primaryColors = const [
    Color(0xffff5252),
    Color(0xff00c853),
    Color(0xff448aff),
    Color(0xffffab00),
  ];

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color,
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
