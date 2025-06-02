import 'package:dev/core/constants/constants.dart';

const appleType = "apple";
const androidType = "android";
const desktopType = "desktop";

class StoreNameSelector {
  static String find(String sheetName) {
    switch (sheetName) {
      case 'Liga.A':
        return StoreNames.arena;
      case 'Liga.B':
        return StoreNames.bolovo;
      case 'Liga.C':
        return StoreNames.caverna;
      default:
        return sheetName;
    }
  }
}
