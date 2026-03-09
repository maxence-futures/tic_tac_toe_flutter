import 'package:flutter/material.dart';

/// A circular avatar showing the first letter of a player's [name].
class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({
    super.key,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
    this.radius = 20,
  });

  final String name;
  final Color backgroundColor;
  final Color textColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        name[0].toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: radius * 0.9,
        ),
      ),
    );
  }
}
