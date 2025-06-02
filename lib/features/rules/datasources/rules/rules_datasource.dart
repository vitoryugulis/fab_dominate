import 'package:dio/dio.dart';
import 'package:googleapis_auth/auth_io.dart';

class RulesDatasource {
  final Dio dio;
  final String credentialsJson; // Receber as credenciais como String

  RulesDatasource({
    required this.dio,
    required this.credentialsJson,
  });

  Future<Map<String, dynamic>> fetch() async {
    final documentId = '1fizAV99bY_Fl5SA4QvjAOQRZH9qbEDW58jsQ-1eDXGs';
    final url = 'https://docs.googleapis.com/v1/documents/$documentId';

    try {
      // Carregar credenciais do JSON fornecido
      final credentials = ServiceAccountCredentials.fromJson(credentialsJson);

      // Obter cliente autenticado
      final client = await clientViaServiceAccount(
        credentials,
        ['https://www.googleapis.com/auth/documents.readonly'],
      );

      // Fazer a requisição com o token de acesso
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${client.credentials.accessToken.data}'
          },
        ),
      );

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