import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF982B1C); // #800000
  static const Color primaryLight = Color(0xFF873229); // #982B1C
  static const Color primaryLighter = Color(0xFF800000);

  static const Color beigeDarker = Color(0xFFc19a57); // #c19a57
  static const Color beigeDark = Color(0xFFDAD4B5); // #DAD4B5
  static const Color beigeLight = Color(0xFFF2E8C6); // #F2E8C6
  static const Color text = Color(0xFF000000); // #000000

  static final Color lightRowColor = primaryLight.withValues(alpha: 0.1);
  static final Color darkRowColor = primaryLight.withValues(alpha: 0.2);
}
