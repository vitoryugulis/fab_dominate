import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  final List<String> rawTexts;
  final String? imageUrl;

  const RulesPage({super.key, required this.rawTexts, this.imageUrl});

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
      appBar: AppBar(
        title: const Text('Regras da Liga Commoner'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              Padding(
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
            // Exibe a imagem, se disponível
            if (imageUrl != null)
              Center(
                child: Image.network(imageUrl!),
              ),
          ],
        ),
      ),
    );
  }
}
