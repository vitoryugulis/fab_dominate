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

  String selectedSheet = 'Player Report - Março';
  final List<String> availableSheets = [
    'Player Report - Março',
    'Player Report - Geral',
    'Hero Report - Geral',
  ];

  List<List<String>> values = [];
  Map<String, double> winsData = {};

  @override
  void initState() {
    super.initState();
    playerHeroDataSource = PlayerHeroDataSource(
      dio: Dio(),
      apiKey: apiKey,
    );
    loadData();
  }

  Future<void> loadData() async {
    hasError = false;
    setState(() {
      values = [];
    });

    try {
      final fetchedValues = await playerHeroDataSource.fetchSheetData(
        sheetName: selectedSheet,
        range: 'A3:E30', // Defina o range adequado para cada planilha
      );
      setState(() {
        values = fetchedValues;
        winsData = _generateWinsData(fetchedValues);
      });
    } catch (e) {
      hasError = true;
      debugPrint('Erro ao carregar dados: $e');
    }
  }

  Map<String, double> _generateWinsData(List<List<String>> data) {
    final map = <String, double>{};
    for (var row in data) {
      if (row.length >= 2) {
        final player = row[0];
        final wins = double.tryParse(row[1]) ?? 0;
        map[player] = wins;
      }
    }
    return map;
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
                // 👉 Menu de seleção da planilha
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
                // 👉 Conteúdo da planilha
                Expanded(
                  child: values.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.beigeLight,
                          ),
                        )
                      : ReportSelectorMenu(
                          values: values,
                          winsData: winsData,
                        ),
                ),
              ],
            )
          : const Center(
              child: Text(
                'Erro ao carregar dados',
                style: TextStyle(color: AppColors.beigeLight),
              ),
            ),
    );
  }
}
