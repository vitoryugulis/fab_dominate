import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/features/rules/datasources/rules/rules_datasource.dart';
import 'package:dev/features/rules/domain/entities/document.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatefulWidget {
  final RulesDatasource rulesDatasource;

  const RulesPage({super.key, required this.rulesDatasource});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  late Future<List<String>> _rulesFuture;

  @override
  void initState() {
    super.initState();
    _rulesFuture = _loadRules();
  }

  Future<List<String>> _loadRules() async {
    final document = await widget.rulesDatasource.fetch();
    return DocumentParser.extractParagraphs(document);
  }

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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _rulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Erro ao carregar as regras. Tente novamente.',
                    style: TextStyle(color: AppColors.primary, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _rulesFuture = _loadRules();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          final parsedParagraphs = _parseParagraphs(snapshot.data ?? []);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                for (var paragraph in parsedParagraphs.skip(1))
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
          );
        },
      ),
    );
  }
}
