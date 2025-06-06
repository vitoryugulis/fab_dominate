import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/utils/name_formatter.dart';
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

    if (values.length <= 1) {
      return Center(
        child: Text(
          'Nenhum dado disponível',
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: 22,
          ),
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

        final double dataFontSize = 14;
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
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.text.withValues(alpha: 0.7),
                  child: SelectableText(
                    name.isNotEmpty ? (index + 1).toString() : '?',
                    style: const TextStyle(
                      color: AppColors.beigeDarker,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        name.formatName(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_outline,
                                  color: AppColors.beigeDarker),
                              const SizedBox(width: 4),
                              SelectableText(
                                'Pontos: $wins',
                                style: TextStyle(
                                  fontSize: dataFontSize,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bar_chart,
                                  color: AppColors.beigeDarker),
                              const SizedBox(width: 4),
                              SelectableText(
                                'Win%: $events',
                                style: TextStyle(
                                  fontSize: dataFontSize,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.emoji_events_outlined,
                                  color: AppColors.beigeDarker),
                              const SizedBox(width: 4),
                              SelectableText(
                                'Vitórias: $rounds',
                                style: TextStyle(
                                  fontSize: dataFontSize,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.replay_outlined,
                                  color: AppColors.beigeDarker),
                              const SizedBox(width: 4),
                              SelectableText(
                                'Rodadas: $winRate',
                                style: TextStyle(
                                  fontSize: dataFontSize,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
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
