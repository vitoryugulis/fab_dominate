import 'package:dev/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RankingTableMobile extends StatelessWidget {
  final List<List<String>> values;

  const RankingTableMobile({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryLight,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: values.length,
      itemBuilder: (context, index) {
        final row = values[index];
        final name = row.isNotEmpty ? row[0] : '';
        final wins = row.length > 1 ? row[1] : '';
        final events = row.length > 2 ? row[2] : '';
        final rounds = row.length > 3 ? row[3] : '';
        final winRate = row.length > 4 ? row[4] : '';

        final rowColor = index % 2 == 0
            ? AppColors.lightRowColor
            : AppColors.darkRowColor;

        return Card(
          color: rowColor,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Player/Hero: $name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Wins: $wins'),
                Text('Events: $events'),
                Text('Rounds: $rounds'),
                Text('WinRate: $winRate'),
              ],
            ),
          ),
        );
      },
    );
  }
}