import 'package:dio/dio.dart';

class PlayerHeroDataSource {
  final Dio dio;
  final String apiKey;

  PlayerHeroDataSource({
    required this.dio,
    required this.apiKey,
  });
  Future<List<List<String>>> fetch({
    required String sheetName,
    String range = 'A1:Z1000', // range padrão
  }) async {
    const spreadsheetId = '1LI5usVvn3UxP6DxRXYNt43MnwQ4P4K2mfxGCkny2JzU';

    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$spreadsheetId/values/$sheetName!$range?key=$apiKey';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        final fetchedValues = (data['values'] as List)
            .map<List<String>>(
                (row) => (row as List).map((cell) => cell.toString()).toList())
            .toList();

        return fetchedValues;
      } else {
        throw Exception('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }
}
