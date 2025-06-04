import 'package:dev/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  final List<String> rawTexts;

  const RulesPage({super.key, required this.rawTexts});

  List<String> _parseParagraphs(List<String> rawTexts) {
    final paragraphs = <String>[];
    var currentParagraph = '';

    for (var text in rawTexts) {
      if (text.contains('\n')) {
        currentParagraph += text.replaceAll('\n', '');
        paragraphs.add(currentParagraph.trim());
        currentParagraph = '';
      } else {
        currentParagraph += text;
      }
    }

    if (currentParagraph.isNotEmpty) {
      paragraphs.add(currentParagraph.trim());
    }

    return paragraphs;
  }

  @override
  Widget build(BuildContext context) {
    final parsedParagraphs = _parseParagraphs(rawTexts);

    return Scaffold(
      backgroundColor: AppColors.beigeLight,
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        title: const Text(
          'Regras da Liga Commoner',
          style: TextStyle(color: AppColors.beigeLight),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.beigeLight,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Volta para a página anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe o título (índice 0)
            if (parsedParagraphs.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  parsedParagraphs.first,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            // Exibe os parágrafos com marcadores
            for (var paragraph in parsedParagraphs.skip(1))
              // Exibe a imagem, se disponível
              paragraph.contains('<image>')
                  ? Center(
                      child: Image.network(
                        paragraph.replaceAll('<image>', '').trim(),
                        errorBuilder: (context, error, stackTrace) {
                          return const Text(
                            'Imagem não disponível',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Expanded(
                            child: Text(
                              paragraph,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}
