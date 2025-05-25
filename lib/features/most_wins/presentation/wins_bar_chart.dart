import 'package:dev/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WinsBarChart extends StatelessWidget {
  final List<List<String>> values;

  const WinsBarChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {

    final List<BarChartGroupData> barGroups = [];

    for (var i = 0; i < values.length; i++) {
      final row = values[i];
      if (row.length >= 2) {
        final wins = double.tryParse(row[1]) ?? 0;
        barGroups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: wins,
                color: AppColors.beigeDark,
                borderRadius: BorderRadius.circular(4),
                width: 18,
              ),
            ],
          ),
        );
      }
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1.6,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxY(barGroups),
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: TextStyle(fontSize: 10, color: AppColors.primaryLight),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= values.length){
                        return const SizedBox();
                      }
                      return Transform.rotate(
                        angle: -0.5,
                        child: Text(
                          values[value.toInt()][0],
                          style: TextStyle(fontSize: 10, color: AppColors.primary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: barGroups,
              backgroundColor: AppColors.primaryLight,
            ),
          ),
        ),
      ),
    );
  }

  double _getMaxY(List<BarChartGroupData> groups) {
    final max = groups
            .map((e) => e.barRods.first.toY)
            .fold<double>(0, (a, b) => a > b ? a : b) +
        5;
    return max < 10 ? 10 : max;
  }
}
