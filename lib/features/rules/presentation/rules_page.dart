import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  final List<String> paragraphs;
  final String? imageUrl;

  const RulesPage({super.key, required this.paragraphs, this.imageUrl});

  @override
  Widget build(BuildContext context) {
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
            for (var paragraph in paragraphs)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  paragraph,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
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
