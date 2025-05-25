import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PlayersDonutChart extends StatefulWidget {
  final List<List<String>> values;

  const PlayersDonutChart({super.key, required this.values});

  @override
  State<PlayersDonutChart> createState() => _PlayersDonutChartState();
}

class _PlayersDonutChartState extends State<PlayersDonutChart> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImage('lib/assets/florian.png');
  }

  Future<void> _loadImage(String assetPath) async {
    final data = await DefaultAssetBundle.of(context).load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      image = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.values
        .map((row) => {
              'name': row.isNotEmpty ? row[0] : 'Unknown',
              'wins': row.length > 1 ? int.tryParse(row[1]) ?? 0 : 0,
            })
        .toList();

    final totalWins = data.fold<int>(
        0, (previous, element) => previous + (element['wins'] as int));

    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: DonutChartPainter(
              data: data,
              totalWins: totalWins,
              image: image!,
            ),
          ),
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
}

/// 🎨 Painter que desenha o Donut com imagens alinhadas corretamente
class DonutChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final int totalWins;
  final ui.Image image;

  DonutChartPainter({
    required this.data,
    required this.totalWins,
    required this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.6;
    double startAngle = -pi / 2;

    for (var item in data) {
      final wins = item['wins'] as int;
      final sweepAngle = (wins / totalWins) * 2 * pi;

      // Desenha a fatia do donut
      final path = Path()
        ..moveTo(
          center.dx + outerRadius * cos(startAngle),
          center.dy + outerRadius * sin(startAngle),
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: outerRadius),
          startAngle,
          sweepAngle,
          false,
        )
        ..lineTo(
          center.dx + innerRadius * cos(startAngle + sweepAngle),
          center.dy + innerRadius * sin(startAngle + sweepAngle),
        )
        ..arcTo(
          Rect.fromCircle(center: center, radius: innerRadius),
          startAngle + sweepAngle,
          -sweepAngle,
          false,
        )
        ..close();

      canvas.save();
      canvas.clipPath(path);

      // 🔥 Posiciona a imagem centralizada no meio da fatia, reta (não gira)
      final middleAngle = startAngle + sweepAngle / 2;
      final radius = (outerRadius + innerRadius) / 2;
      final imageCenter = Offset(
        center.dx + radius * cos(middleAngle),
        center.dy + radius * sin(middleAngle),
      );

      final imageSize = Size(
        (outerRadius - innerRadius) * 1.5,
        (outerRadius - innerRadius) * 1.5,
      );

      final imageRect = Rect.fromCenter(
        center: imageCenter,
        width: imageSize.width,
        height: imageSize.height,
      );

      paintImage(
        canvas: canvas,
        rect: imageRect,
        image: image,
        fit: BoxFit.cover,
      );

      canvas.restore();

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) => true;
}
