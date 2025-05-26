//import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

class OriginDevice {
  static bool isMobileWeb() {
    try {
      final userAgent =
          (Uri.base.queryParameters['userAgent'] ?? '').toLowerCase();
      return userAgent.contains('android') || userAgent.contains('iphone') || !kIsWeb;
    } catch (e) {
      return false;
    }
  }
}
