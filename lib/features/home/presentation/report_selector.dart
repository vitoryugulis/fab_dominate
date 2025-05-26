import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/utils/origin_device.dart';
import 'package:dev/features/most_wins/presentation/wins_donut_chart.dart';
import 'package:dev/features/player_ranking/presentation/ranking_table.dart';
import 'package:dev/features/player_ranking/presentation/ranking_table_mobile.dart';
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
                selectedReport == 'Wins Donut Chart',
              ],
              onPressed: (index) {
                setState(() {
                  if (index == 0) {
                    selectedReport = 'Ranking';
                  } else {
                    selectedReport = 'Wins Donut Chart';
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
                  child: Text('Wins Donut Chart'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: () {
              switch (selectedReport) {
                case 'Ranking':
                  return OriginDevice.isMobileWeb()
                      ? RankingTableMobile(values: widget.values)
                      : RankingTable(values: widget.values);
                case 'Wins Donut Chart':
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final height = constraints.maxHeight;
                      final width = height;

                      return Center(
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: WinsDonutChart(values: widget.values),
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
