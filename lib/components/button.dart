import 'package:flutter/material.dart';

class OneButton extends StatelessWidget {
  const OneButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.width,
    required this.color,
    this.icon,
  }) : super(key: key);
  final String text;
  final Function()? onTap;
  final double width;
  final Color color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
