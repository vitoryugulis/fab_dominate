import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF800000); // #222831
  static const Color primaryLight = Color(0xFF982B1C); // #393E46
  static const Color beigeDark = Color(0xFFDAD4B5); // #948979
  static const Color beigeLight = Color(0xFFF2E8C6); // #DFD0B8
  static const Color text = Color(0xFF000000); // #DFD0B8

  static final Color lightRowColor = primaryLight.withValues(alpha: 0.1);
  static final Color darkRowColor = primaryLight.withValues(alpha: 0.2);
}
