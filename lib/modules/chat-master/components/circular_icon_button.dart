import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final void Function()? onPress;
  const CircularIconButton({
    Key? key,
    required this.color,
    required this.label,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          margin: const EdgeInsets.all(20),
          height: 60,
          width: 60,
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            onPressed: onPress,
          ),
        ),
        Text(label)
      ],
    );
  }
}
