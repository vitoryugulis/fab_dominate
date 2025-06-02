import 'package:dev/core/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseDataSource {
  final FirebaseRemoteConfig remoteConfig;

  FirebaseDataSource({required this.remoteConfig});

  static Future<FirebaseDataSource> initialize() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Credentials.firebaseApiKey,
        appId: Credentials.firebaseAppId,
        messagingSenderId: Credentials.firebaseMessagingSenderId,
        projectId: Credentials.firebaseProjectId,
      ),
    );
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setDefaults({'google_docs_json': ''});

    await remoteConfig.fetchAndActivate();

    return FirebaseDataSource(remoteConfig: remoteConfig);
  }

  String get docsJson => remoteConfig.getString('google_docs_json');
}
