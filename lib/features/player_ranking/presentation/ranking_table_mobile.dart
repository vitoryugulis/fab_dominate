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
        final name = row.isNotEmpty ? row[0] : 'Unknown';
        final wins = row.length > 1 ? row[1] : '0';
        final events = row.length > 2 ? row[2] : '0';
        final rounds = row.length > 3 ? row[3] : '0';
        final winRate = row.length > 4 ? row[4] : '0%';

        final rowColor =
            index % 2 == 0 ? AppColors.lightRowColor : AppColors.darkRowColor;

        return Card(
          color: rowColor,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar ou ícone do jogador
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    name.isNotEmpty ? name[0] : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Informações do jogador
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.emoji_events,
                              color: AppColors.primaryLight),
                          const SizedBox(width: 8),
                          Text('Wins: $wins'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.event,
                              color: AppColors.primaryLight),
                          const SizedBox(width: 8),
                          Text('Events: $events'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.timer,
                              color: AppColors.primaryLight),
                          const SizedBox(width: 8),
                          Text('Rounds: $rounds'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(Icons.percent,
                              color: AppColors.primaryLight),
                          const SizedBox(width: 8),
                          Text('WinRate: $winRate'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
