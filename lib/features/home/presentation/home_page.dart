import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/constants/constants.dart';
import 'package:dev/features/home/data/datasources/player_hero/player_hero_datasource.dart';
import 'package:dev/features/home/presentation/widgets/prototype_warning_dialog.dart';
import 'package:dev/features/home/presentation/widgets/report_selector.dart';
import 'package:dev/features/home/presentation/widgets/sheet_selector.dart';
import 'package:dev/features/rules/datasources/google_auth/google_auth_manager.dart';
import 'package:dev/features/rules/datasources/rules/rules_datasource.dart';
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
  late final Widget rulesPage;

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
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    playerHeroDataSource = PlayerHeroDataSource(
      dio: Dio(),
      apiKey: Credentials.apiKey,
    );
    rulesDatasource = RulesDatasource(
      dio: Dio(),
      authManager: GoogleAuthManager(Credentials.firebase.docsJson),
    );

    rulesPage = RulesPage(rulesDatasource: rulesDatasource);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => const PrototypeWarningDialog(),
      );
    });

    loadData();
  }

  Future<void> loadData() async {
    hasError = false;
    setState(() {
      playerData = [];
      heroData = [];
      imageUrl = null;
    });

    final stopwatch = Stopwatch()..start();

    try {
      final results = await Future.wait([
        playerHeroDataSource.fetch(
          sheetName: selectedSheet,
          range: sheetRangePlayers,
        ),
        playerHeroDataSource.fetch(
          sheetName: selectedSheet,
          range: sheetRangeHeroes,
        ),
      ]);

      stopwatch.stop();
      debugPrint(
          'Tempo total para carregar playerSheet e heroSheet: ${stopwatch.elapsedMilliseconds} ms');

      setState(() {
        playerData = results.first;
        heroData = results.last;
      });
    } catch (e) {
      stopwatch.stop();
      setState(() {
        hasError = true;
      });
      debugPrint('Erro ao carregar dados: $e');
    }
  }

  navigateToRulesPage() {
    try {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => rulesPage,
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
    final mediaWidth = MediaQuery.of(context).size.width;
    final isMobile = mediaWidth < 1000;
    double horizontalPadding = isMobile ? 5 : mediaWidth * 0.07;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Liga Commoner PROTOTYPE',
          style: const TextStyle(color: AppColors.beigeDarker),
        ),
        leading: IconButton(
          icon: const Icon(Icons.rule, color: AppColors.beigeDarker),
          onPressed: navigateToRulesPage,
        ),
      ),
      body: Container(
        color: AppColors.beigeLight,
        child: Stack(
          children: [
            // Imagem de fundo
            Positioned.fill(
              child: Image.asset(
                'lib/assets/paper.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            // Conteúdo principal
            !hasError
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

            if (!isMobile)
              IgnorePointer(
                ignoring: true,
                child: Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: AppColors.beigeDarker,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            if (!isMobile)
              IgnorePointer(
                ignoring: true,
                child: Positioned.fill(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: horizontalPadding - 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: AppColors.beigeDarker,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
