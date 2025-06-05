import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/features/rules/datasources/rules/rules_datasource.dart';
import 'package:dev/features/rules/domain/entities/document.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _openImageInNewTab(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Não foi possível abrir a URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Scaffold(
      backgroundColor: AppColors.beigeDarker,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Regras',
          style: TextStyle(color: AppColors.beigeDarker),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.beigeDarker,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'lib/assets/paper.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWeb = constraints.maxWidth > 800;
                final horizontalPadding = isWeb ? 200.0 : 32.0;

                return FutureBuilder<List<String>>(
                  future: _rulesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Erro ao carregar as regras. Tente novamente.',
                              style: TextStyle(
                                  color: AppColors.primary, fontSize: 22),
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

                    final parsedParagraphs =
                        _parseParagraphs(snapshot.data ?? []);
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding / 2,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding / 2),
                        decoration: !isWeb
                            ? null
                            : BoxDecoration(
                                border: Border.symmetric(
                                  vertical: BorderSide(
                                    color: AppColors.beigeDarker,
                                    width: 2,
                                  ),
                                ),
                              ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (parsedParagraphs.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16, top: 80),
                                child: SelectableText(
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
                                      child: GestureDetector(
                                        onTap: () => _openImageInNewTab(
                                            paragraph
                                                .replaceAll('<image>', '')
                                                .trim()),
                                        child: Image.network(
                                          paragraph
                                              .replaceAll('<image>', '')
                                              .trim(),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Text(
                                              'Imagem não disponível',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primary,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '• ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Expanded(
                                            child: SelectableText(
                                              paragraph,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
