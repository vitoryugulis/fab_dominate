import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleAuthManager {
  final String credentialsJson;
  AccessCredentials? _cachedCredentials;
  AutoRefreshingAuthClient? _authClient;

  GoogleAuthManager(this.credentialsJson);

  Future<AutoRefreshingAuthClient> getClient() async {
    final stopwatch = Stopwatch()..start();

    if (_authClient != null && _cachedCredentials != null) {
      // Reutilizar cliente autenticado se o token ainda for válido
      if (!_cachedCredentials!.accessToken.hasExpired) {
        stopwatch.stop();
        debugPrint(
            'Tempo para reutilizar cliente autenticado: ${stopwatch.elapsedMilliseconds} ms');
        return _authClient!;
      }
    }

    // Autenticar e criar um novo cliente
    final credentials = ServiceAccountCredentials.fromJson(credentialsJson);
    _authClient = await clientViaServiceAccount(
      credentials,
      ['https://www.googleapis.com/auth/documents.readonly'],
    );
    _cachedCredentials = _authClient!.credentials;

    stopwatch.stop();
    debugPrint(
        'Tempo para autenticar e criar cliente: ${stopwatch.elapsedMilliseconds} ms');
    return _authClient!;
  }
}
