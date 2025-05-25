import 'dart:math';
import 'package:flutter/material.dart';

/// 🎯 Donut Chart com imagem nas fatias
class PlayersDonutChart extends StatelessWidget {
  final List<List<String>> values;

  const PlayersDonutChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    final data = values
        .map((row) => {
      'name': row.isNotEmpty ? row[0] : 'Unknown',
      'wins': row.length > 1 ? int.tryParse(row[1]) ?? 0 : 0,
    })
        .toList();

    final totalWins = data.fold<int>(
        0, (previous, element) => previous + (element['wins'] as int));

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          // 🧩 Desenha cada fatia
          for (int i = 0; i < data.length; i++) ...[
            _buildSlice(
              startAngle: data.sublist(0, i).fold<double>(
                  0,
                      (sum, item) =>
                  sum + ((item['wins'] as int) / totalWins) * 360),
              sweepAngle: ((data[i]['wins'] as int) / totalWins) * 360,
              image: const AssetImage('lib/assets/florian.png'),
            ),
          ],
          // 🕳️ Furo central para virar Donut
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  'Wins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSlice({
    required double startAngle,
    required double sweepAngle,
    required ImageProvider image,
  }) {
    return Positioned.fill(
      child: Transform.rotate(
        angle: startAngle * pi / 180,
        child: ClipPath(
          clipper: PieSliceClipper(sweepAngle),
          child: Image(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// 🔺 Clipper que desenha uma fatia
class PieSliceClipper extends CustomClipper<Path> {
  final double sweepAngle;
  final double innerRadiusFactor;

  PieSliceClipper(
      this.sweepAngle, {
        this.innerRadiusFactor = 0.6, // 🕳️ Define o tamanho do furo
      });

  @override
  Path getClip(Size size) {
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * innerRadiusFactor;
    final center = Offset(outerRadius, outerRadius);

    final path = Path();

    // Começa no arco externo
    path.moveTo(center.dx, center.dy - outerRadius);
    path.arcTo(
      Rect.fromCircle(center: center, radius: outerRadius),
      -pi / 2,
      sweepAngle * pi / 180,
      false,
    );
    path.lineTo(
      center.dx +
          innerRadius *
              cos((sweepAngle - 90) *
                  pi /
                  180), // Move para o ponto do arco interno
      center.dy +
          innerRadius *
              sin((sweepAngle - 90) *
                  pi /
                  180), // Move para o ponto do arco interno
    );
    path.arcTo(
      Rect.fromCircle(center: center, radius: innerRadius),
      (sweepAngle - 90) * pi / 180,
      -sweepAngle * pi / 180,
      false,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(PieSliceClipper oldClipper) =>
      oldClipper.sweepAngle != sweepAngle ||
          oldClipper.innerRadiusFactor != innerRadiusFactor;
}
