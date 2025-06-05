import 'package:dev/features/rules/datasources/firebase/firebase_datasource.dart';

class Credentials {
  static late String apiKey;
  static late String firebaseAppId;
  static late String firebaseApiKey;
  static late String firebaseMessagingSenderId;
  static late String firebaseProjectId;
  static late FirebaseDataSource firebase;
}

class Flavors {
  static const String dev = 'dev';
  static const String prod = 'prod';
}

class HeroReportColumns {
  static const int name = 0;
  static const int wins = 1;
  static const int rounds = 2;
  static const int winPercentage = 3;
}

class PlayerReportColumns {
  static const int name = 0;
  static const int points = 1;
  static const int wins = 2;
  static const int rounds = 3;
  static const int winPercentage = 4;
}

class StoreNames {
  static const String bolovo = 'Bolovo Games';
  static const String arena = 'Arena Geek';
  static const String caverna = 'Caverna do Dragão';
}
