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
  ui.Image? centerImage;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final florian = await _loadImage('lib/assets/florian.png');
    final fab = await _loadImage('lib/assets/fab.png');
    setState(() {
      image = florian;
      centerImage = fab;
    });
  }

  Future<ui.Image> _loadImage(String assetPath) async {
    final data = await DefaultAssetBundle.of(context).load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
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

    if (image == null || centerImage == null) {
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
          // 🔥 Imagem no centro, circular
          Center(
            child: Container(
              width: 220, // 🔧 Ajuste o tamanho conforme desejar
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
                image: DecorationImage(
                  image: AssetImage('lib/assets/fab.png'),
                  fit: BoxFit.cover,
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
