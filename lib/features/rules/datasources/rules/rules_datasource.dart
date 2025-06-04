import 'package:dev/features/rules/datasources/google_auth/google_auth_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RulesDatasource {
  final Dio dio;
  final GoogleAuthManager authManager;
  RulesDatasource({
    required this.dio,
    required this.authManager,
  });

  Future<Map<String, dynamic>> fetch() async {
    final documentId = '1fizAV99bY_Fl5SA4QvjAOQRZH9qbEDW58jsQ-1eDXGs';
    final url = 'https://docs.googleapis.com/v1/documents/$documentId';

    try {
      final client = await authManager.getClient();
      final stopwatchRequest = Stopwatch()..start();
      // Fazer a requisição com o token de acesso
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${client.credentials.accessToken.data}'
          },
        ),
      );
      stopwatchRequest.stop();
      debugPrint(
          'Tempo para fazer a requisição: ${stopwatchRequest.elapsedMilliseconds} ms');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Erro ao buscar o documento: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar o documento: $e');
    }
  }
}
