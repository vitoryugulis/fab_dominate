import 'package:universal_html/html.dart' as html;

const appleType = "apple";
const androidType = "android";
const desktopType = "desktop";

class OriginDevice {
  static bool isMobileWeb() {
    final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
    // smartphone
    if (userAgent.contains("iphone")) return true;
    if (userAgent.contains("android")) return true;

    // tablet
    if (userAgent.contains("ipad")) return true;
    return false;
  }
}
