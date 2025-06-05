import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/core/utils/name_formatter.dart';
import 'package:flutter/material.dart';

/// 🔥 Widget principal que combina a Tabela + Gráfico
class RankingTable extends StatelessWidget {
  final List<List<String>> values;

  const RankingTable({super.key, required this.values});

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

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [PlayersRankingTable(values: values)],
        ),
      ),
    );
  }
}

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
            child: Container(
              decoration: BoxDecoration(
                color:
                    Colors.white, // cor de fundo da tabela (ajuste se quiser)
                borderRadius:
                    BorderRadius.circular(12), // cantos arredondados (opcional)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
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
                  DataColumn(label: Text('Jogador')),
                  DataColumn(label: Text('Pontos')),
                  DataColumn(label: Text('Win%')),
                  DataColumn(label: Text('Vitórias')),
                  DataColumn(label: Text('Rodadas')),
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
                        DataCell(SelectableText(name.formatName())),
                        DataCell(SelectableText(wins)),
                        DataCell(SelectableText(events)),
                        DataCell(SelectableText(rounds)),
                        DataCell(SelectableText(winRate)),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
