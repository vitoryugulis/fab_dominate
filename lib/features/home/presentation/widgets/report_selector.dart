import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/utils/origin_device.dart';
import 'package:dev/features/most_wins/presentation/wins_donut_chart.dart';
import 'package:dev/features/player_ranking/presentation/ranking_table.dart';
import 'package:dev/features/player_ranking/presentation/ranking_table_mobile.dart';
import 'package:flutter/material.dart';

class ReportSelectorMenu extends StatefulWidget {
  final List<List<String>> playerData;
  final List<List<String>> winsData;

  const ReportSelectorMenu({
    super.key,
    required this.playerData,
    required this.winsData,
  });

  @override
  State<ReportSelectorMenu> createState() => _ReportSelectorMenuState();
}

const String heroLabel = 'Heróis';
const String playerLabel = 'Jogadores';

class _ReportSelectorMenuState extends State<ReportSelectorMenu> {
  String selectedReport = playerLabel;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ToggleButtons(
              isSelected: [
                selectedReport == playerLabel,
                selectedReport == heroLabel,
              ],
              onPressed: (index) {
                setState(() {
                  if (index == 0) {
                    selectedReport = playerLabel;
                  } else {
                    selectedReport = heroLabel;
                  }
                });
              },
              borderRadius: BorderRadius.circular(12),
              selectedColor: AppColors.beigeLight,
              fillColor: AppColors.primaryLight,
              color: AppColors.primary,
              borderColor: AppColors.beigeDark,
              selectedBorderColor: AppColors.beigeDark,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(playerLabel),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(heroLabel),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: () {
              switch (selectedReport) {
                case playerLabel:
                  return OriginDevice.isMobileWeb()
                      ? RankingTableMobile(values: widget.playerData)
                      : RankingTable(values: widget.playerData);
                case heroLabel:
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final height = constraints.maxHeight;
                      final width = height;

                      return Center(
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: WinsDonutChart(values: widget.winsData),
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
