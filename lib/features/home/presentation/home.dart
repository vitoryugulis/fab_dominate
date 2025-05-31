import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/constants/constants.dart';
import 'package:dev/features/home/data/datasources/player_hero/player_hero.dart';
import 'package:dev/features/home/presentation/report_selector.dart';
import 'package:dev/features/home/presentation/sheet_selector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PlayerHeroDataSource playerHeroDataSource;
  bool hasError = false;

  String selectedSheet = 'LIGA.SEA';
  final List<String> availableSheets = [
    'LIGA.SEA'
    // 'Player Report - Março',
    // 'Player Report - Geral',
    // 'Hero Report - Geral',
  ];

  // final String sheetRangePlayerReports = 'G3:K35';

  //Liga Commoner 13 Dominate
  final String sheetRangePlayers = 'B2:F35';
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
    loadData();
  }

  Future<void> loadData() async {
    hasError = false;
    setState(() {
      playerData = [];
      heroData = [];
    });

    try {
      final playerSheet = await playerHeroDataSource.fetchSheetData(
        sheetName: selectedSheet,
        range: sheetRangePlayers, // Defina o range adequado para cada planilha
      );

      final heroSheet = await playerHeroDataSource.fetchSheetData(
        sheetName: selectedSheet,
        range: sheetRangeHeroes, // Defina o range adequado para cada planilha
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.beigeLight,
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        title: Text(
          'Relatórios - $selectedSheet',
          style: const TextStyle(color: AppColors.beigeLight),
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
