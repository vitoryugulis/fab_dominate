import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart' as io;

class OriginDevice {
  static bool isMobileWeb() {
    final userAgent = io.Platform.environment['HTTP_USER_AGENT'] ?? '';
    return userAgent.contains('Android') ||
        userAgent.contains('iPhone') ||
        !kIsWeb;
  }
}
