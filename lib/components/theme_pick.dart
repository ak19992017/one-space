import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../constants/theme_provider.dart';

class ThemePicker extends StatefulWidget {
  const ThemePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<ThemePicker> createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    return SizedBox(
      height: (450 - (17 * 2) - (10 * 2)) / 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppColors.primaryColors.length,
        itemBuilder: (context, index) {
          bool isSelectedColor = AppColors.primaryColors[index] ==
              themeProvider.selectedPrimaryColor;
          return GestureDetector(
            onTap: isSelectedColor
                ? null
                : () {
                    themeProvider.setSelectedPrimaryColor(
                        AppColors.primaryColors[index]);
                  },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 6,
              decoration: BoxDecoration(
                color: AppColors.primaryColors[index],
                borderRadius: BorderRadius.circular(10),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelectedColor ? 1 : 0,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                      child: const Icon(EvaIcons.checkmark),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
