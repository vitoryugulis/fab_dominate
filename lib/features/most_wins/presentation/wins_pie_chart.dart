import 'package:dev/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WinsPieChart extends StatefulWidget {
  final List<List<String>> values;

  const WinsPieChart({super.key, required this.values});

  @override
  State<WinsPieChart> createState() => _WinsPieChartState();
}

class _WinsPieChartState extends State<WinsPieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final totalWins = widget.values.fold<double>(
      0,
      (sum, row) => sum + (double.tryParse(row[1]) ?? 0),
    );

    final sections = List.generate(widget.values.length, (i) {
      final row = widget.values[i];
      if (row.length < 2) return null;

      final playerName = row[0];
      final wins = double.tryParse(row[1]) ?? 0;
      if (wins <= 0) return null;

      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 280 : 220;
      final double fontSize = isTouched ? 18 : 14;
      final double percentage = (wins / totalWins) * 100;

      return PieChartSectionData(
        value: wins,
        color: _getColor(i),
        title: '$playerName\n${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.55,
      );
    }).whereType<PieChartSectionData>().toList();

    if (sections.isEmpty) {
      return const Center(child: Text('No data to display'));
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.6,
        child: PieChart(
          PieChartData(
            sections: sections,
            centerSpaceRadius: 60,
            sectionsSpace: 4,
            borderData: FlBorderData(show: false),
            pieTouchData: PieTouchData(
              touchCallback: (event, response) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      response == null ||
                      response.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex = response.touchedSection!.touchedSectionIndex;
                });
              },
              enabled: true,
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    final colors = [
      AppColors.primary,
      AppColors.primaryLight,
      AppColors.beigeDark,
      AppColors.beigeLight,
      Colors.teal,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.blue,
      Colors.green,
    ];
    return colors[index % colors.length];
  }
}
