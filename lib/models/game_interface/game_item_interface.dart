import 'package:flutter/material.dart';

abstract class GameItemInterface {
  final String name;
  final String icon;
  final Color color;

  GameItemInterface({
    required this.name,
    required this.icon,
    required this.color,
  });
}
