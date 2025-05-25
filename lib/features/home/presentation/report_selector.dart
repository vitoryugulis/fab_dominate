import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/features/most_wins/presentation/wins_bar_chart.dart';
import 'package:dev/features/most_wins/presentation/wins_pie_chart.dart'; // importe o WinsPieChart
import 'package:dev/features/player_ranking/presentation/ranking_table.dart';
import 'package:flutter/material.dart';

class ReportSelectorMenu extends StatefulWidget {
  final List<List<String>> values;
  final Map<String, double> winsData;

  const ReportSelectorMenu({
    super.key,
    required this.values,
    required this.winsData,
  });

  @override
  State<ReportSelectorMenu> createState() => _ReportSelectorMenuState();
}

class _ReportSelectorMenuState extends State<ReportSelectorMenu> {
  String selectedReport = 'Ranking';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.beigeLight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ToggleButtons(
              isSelected: [
                selectedReport == 'Ranking',
                selectedReport == 'Wins Bar Chart',
                selectedReport == 'Wins Pie Chart',
              ],
              onPressed: (index) {
                setState(() {
                  if (index == 0) {
                    selectedReport = 'Ranking';
                  } else if (index == 1) {
                    selectedReport = 'Wins Bar Chart';
                  } else {
                    selectedReport = 'Wins Pie Chart';
                  }
                });
              },
              borderRadius: BorderRadius.circular(12),
              selectedColor: AppColors.beigeLight,
              fillColor: AppColors.primaryLight,
              color: AppColors.primary,
              borderColor: AppColors.beigeDark,
              selectedBorderColor: AppColors.beigeDark,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Ranking'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Wins Bar Chart'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Wins Pie Chart'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: () {
              switch (selectedReport) {
                case 'Ranking':
                  return PlayersRankingTable(values: widget.values);
                case 'Wins Bar Chart':
                  return WinsBarChart(values: widget.values);
                case 'Wins Pie Chart':
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final height = constraints.maxHeight *
                          0.6; // 60% da altura disponível
                      final width =
                          height; // tamanho quadrado para o círculo ficar redondo

                      return Center(
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: WinsPieChart(values: widget.values),
                        ),
                      );
                    },
                  );
                default:
                  return const SizedBox();
              }
            }(),
          ),
        ],
      ),
    );
  }
}
