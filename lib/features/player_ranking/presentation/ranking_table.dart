import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/features/player_ranking/presentation/donut_chart.dart';
import 'package:flutter/material.dart';

/// 🔥 Widget principal que combina a Tabela + Gráfico
class PlayersRankingWithChart extends StatelessWidget {
  final List<List<String>> values;

  const PlayersRankingWithChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFDFD0B8),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: PlayersRankingTable(values: values),
          ),
          Expanded(
            flex: 1,
            child: PlayersDonutChart(values: values),
          ),
        ],
      ),
    );
  }
}

/// 🏆 Tabela de Ranking
class PlayersRankingTable extends StatelessWidget {
  final List<List<String>> values;

  const PlayersRankingTable({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable(
              headingRowColor: WidgetStateColor.resolveWith(
                (_) => AppColors.primaryLight,
              ),
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.beigeLight,
                fontSize: 20,
              ),
              dataTextStyle: const TextStyle(
                color: AppColors.primaryLight,
                fontSize: 18,
              ),
              columns: const [
                DataColumn(label: Text('Rank')),
                DataColumn(label: Text('Player')),
                DataColumn(label: Text('Wins')),
                DataColumn(label: Text('Events')),
                DataColumn(label: Text('Rounds')),
                DataColumn(label: Text('WinRate')),
              ],
              rows: List<DataRow>.generate(
                values.length,
                (index) {
                  final row = values[index];
                  final name = row.isNotEmpty ? row[0] : '';
                  final wins = row.length > 1 ? row[1] : '';
                  final events = row.length > 2 ? row[2] : '';
                  final rounds = row.length > 3 ? row[3] : '';
                  final winRate = row.length > 4 ? row[4] : '';

                  final rowColor = index % 2 == 0
                      ? AppColors.lightRowColor
                      : AppColors.darkRowColor;

                  return DataRow(
                    color: WidgetStateColor.resolveWith((_) => rowColor),
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(name)),
                      DataCell(Text(wins)),
                      DataCell(Text(events)),
                      DataCell(Text(rounds)),
                      DataCell(Text(winRate)),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
