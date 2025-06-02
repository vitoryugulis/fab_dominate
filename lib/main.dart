import 'package:dev/core/constants/constants.dart';
import 'package:dev/features/home/presentation/home_page.dart';
import 'package:dev/features/rules/datasources/firebase/firebase_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await _configureCredentials();

  runApp(const MaterialApp(home: Home()));
}

Future<void> _configureCredentials() async {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: Flavors.dev);
  //APIKEY

  if (flavor == Flavors.dev) {
    await dotenv.load(fileName: 'dev.env');
  }

  Credentials.apiKey = flavor == Flavors.dev
      ? dotenv.env['API_KEY'] ?? ''
      : const String.fromEnvironment('API_KEY');

  //FIREBASE
  await _initializeFirebase(flavor);
}

Future<void> _initializeFirebase(String flavor) async {
  final isDev = flavor == Flavors.dev;
  Credentials.firebaseAppId = isDev
      ? dotenv.env['FIREBASE_APP_ID'] ?? ''
      : const String.fromEnvironment('FIREBASE_APP_ID');

  Credentials.firebaseApiKey = isDev
      ? dotenv.env['FIREBASE_API_KEY'] ?? ''
      : const String.fromEnvironment('FIREBASE_API_KEY');

  Credentials.firebaseMessagingSenderId = isDev
      ? dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? ''
      : const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');

  Credentials.firebaseProjectId = isDev
      ? dotenv.env['FIREBASE_PROJECT_ID'] ?? ''
      : const String.fromEnvironment('FIREBASE_PROJECT_ID');

  try {
    Credentials.firebase = await FirebaseDataSource.initialize();
  } catch (e) {
    debugPrint(e.toString());
  }
}
