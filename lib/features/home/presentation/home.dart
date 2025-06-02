import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/constants/constants.dart';
import 'package:dev/features/home/data/datasources/player_hero/player_hero_datasource.dart';
import 'package:dev/features/home/presentation/report_selector.dart';
import 'package:dev/features/home/presentation/sheet_selector.dart';
import 'package:dev/features/rules/datasources/rules/rules_datasource.dart';
import 'package:dev/features/rules/domain/entities/document.dart';
import 'package:dev/features/rules/presentation/rules_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PlayerHeroDataSource playerHeroDataSource;
  late final RulesDatasource rulesDatasource;
  final documentId = '1fizAV99bY_Fl5SA4QvjAOQRZH9qbEDW58jsQ-1eDXGs';

  bool hasError = false;

  String selectedSheet = 'Liga.A';
  final List<String> availableSheets = [
    'Liga.A',
    'Liga.B',
    'Liga.C',
  ];

  final String sheetRangePlayers = 'B3:F35';
  final String sheetRangeHeroes = 'G2:I30';

  List<List<String>> playerData = [];
  List<List<String>> heroData = [];

  @override
  void initState() {
    super.initState();
    playerHeroDataSource = PlayerHeroDataSource(
      dio: Dio(),
      apiKey: Credentials.apiKey,
    );

    rulesDatasource = RulesDatasource(
      dio: Dio(),
      credentialsJson: Credentials.firebase.docsJson,
    );

    loadData();
  }

  Future<void> loadData() async {
    hasError = false;
    setState(() {
      playerData = [];
      heroData = [];
    });

    try {
      final playerSheet = await playerHeroDataSource.fetch(
        sheetName: selectedSheet,
        range: sheetRangePlayers,
      );

      final heroSheet = await playerHeroDataSource.fetch(
        sheetName: selectedSheet,
        range: sheetRangeHeroes,
      );

      setState(() {
        playerData = playerSheet;
        heroData = heroSheet;
      });
    } catch (e) {
      hasError = true;
      debugPrint('Erro ao carregar dados: $e');
    }
  }

  Future<void> navigateToRulesPage() async {
    try {
      final document = await rulesDatasource.fetch();
      final paragraphs = DocumentParser.extractParagraphs(document);
      final imageUrl = DocumentParser.extractImage(document);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RulesPage(
            paragraphs: paragraphs,
            imageUrl: imageUrl,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Erro ao buscar regras: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao carregar as regras. Tente novamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.beigeLight,
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        title: Text(
          'Liga Commoner 13 Dominate',
          style: const TextStyle(color: AppColors.beigeLight),
        ),
        leading: IconButton(
          icon: const Icon(Icons.rule, color: AppColors.beigeLight),
          onPressed: navigateToRulesPage,
        ),
      ),
      body: !hasError
          ? Column(
              children: [
                SheetSelectorMenu(
                  sheets: availableSheets,
                  selectedSheet: selectedSheet,
                  onSheetSelected: (sheet) {
                    setState(() {
                      selectedSheet = sheet;
                    });
                    loadData();
                  },
                ),
                Expanded(
                  child: heroData.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : ReportSelectorMenu(
                          playerData: playerData,
                          winsData: heroData,
                        ),
                ),
              ],
            )
          : const Center(
              child: Text(
                'Erro ao carregar dados. Recarregue a tela ou peça ajuda ao administrador',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
    );
  }
}
