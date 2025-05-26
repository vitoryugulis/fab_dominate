import 'package:dev/core/constants/constants.dart';
import 'package:dev/features/home/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  if (flavor == 'dev') {
    await dotenv.load(fileName: 'dev.env');
  }

  Credentials.apiKey = flavor == 'dev'
      ? dotenv.env['API_KEY'] ?? ''
      : const String.fromEnvironment('API_KEY');

  runApp(const MaterialApp(home: Home()));
}
