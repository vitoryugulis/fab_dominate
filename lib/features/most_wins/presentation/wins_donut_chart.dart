import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:dev/core/constants/constants.dart';
import 'package:dev/core/constants/heroes/adult_hero_assets.dart';
import 'package:dev/core/constants/heroes/young_hero_image_mapper.dart';
import 'package:dev/core/utils/origin_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WinsDonutChart extends StatefulWidget {
  final List<List<String>> values;

  const WinsDonutChart({super.key, required this.values});

  @override
  State<WinsDonutChart> createState() => _PlayersDonutChartState();
}

class _PlayersDonutChartState extends State<WinsDonutChart> {
  final Map<String, ui.Image> heroImages = {};
  ui.Image? centerImage;
  Map<String, double> winsData = {};

  @override
  void initState() {
    super.initState();
    _loadAllHeroImages();
  }

  Map<String, double> _generateWinsData(List<List<String>> data) {
    final winsMap = <String, double>{};
    for (var row in data) {
      if (row.length >= 2) {
        final hero = row[0];
        final wins = double.tryParse(row[1]) ?? 0;
        winsMap[hero] = wins;
      }
    }
    return winsMap;
  }

  Future<void> _loadAllHeroImages() async {
    final futures = widget.values.map((row) async {
      final name = row.isNotEmpty ? row[HeroReportColumns.name] : 'Unknown';
      final assetPath = YoungHeroImageMapper.getImageUrl(name) ?? '';

      final image = await _loadAssetImage(assetPath);
      if (image != null) {
        heroImages[name] = image;
      }
    }).toList();

    await Future.wait(futures);

    final center = await _loadAssetImage('lib/assets/fab.jpg');
    if (!mounted) return;
    setState(() {
      centerImage = center;
      winsData = _generateWinsData(widget.values);
    });
  }

  Future<ui.Image?> _loadAssetImage(String assetPath) async {
    assetPath = assetPath.isEmpty ? AdultHeroAssets.other : assetPath;
    try {
      final data = await rootBundle.load(assetPath);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      return frame.image;
    } catch (e) {
      debugPrint('Erro ao carregar imagem do asset $assetPath: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalWins = winsData.values.fold(0.0, (a, b) => a + b);

    if (winsData.isEmpty || centerImage == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final double minSize = OriginDevice.isMobileWeb() ? 100 : 370;
    final double maxSize = 230;

    final double centralLogoSize = !OriginDevice.isMobileWeb()
        ? max(maxSize, min(MediaQuery.of(context).size.width * 0.25, minSize))
        : MediaQuery.of(context).size.width * 0.55;

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: DonutChartPainter(
              data: winsData,
              totalWins: totalWins,
              heroImages: heroImages,
            ),
          ),
          Center(
            child: Container(
              width: centralLogoSize,
              height: centralLogoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
                image: DecorationImage(
                  image: const AssetImage('lib/assets/fab.jpg'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final Map<String, double> data;
  final double totalWins;
  final Map<String, ui.Image> heroImages;

  DonutChartPainter({
    required this.data,
    required this.totalWins,
    required this.heroImages,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.6;
    double startAngle = -pi / 2;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadius * 0.08
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    final shadowPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: outerRadius))
      ..addOval(Rect.fromCircle(center: center, radius: innerRadius))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(shadowPath, shadowPaint);

    data.forEach((name, wins) {
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
      final offsetY = !OriginDevice.isMobileWeb() ? 50.0 : 20;

      final imageCenter = Offset(
        center.dx + radius * cos(middleAngle),
        center.dy + radius * sin(middleAngle) + offsetY,
      );
      final sweepRatio = sweepAngle / (2 * pi);
      final zoomFactor = ui.lerpDouble(2, 7, sweepRatio) ?? 2.0;

      final imageSize = Size(
        (outerRadius - innerRadius) * zoomFactor,
        (outerRadius - innerRadius) * zoomFactor,
      );

      final imageRect = Rect.fromCenter(
        center: imageCenter,
        width: imageSize.width,
        height: imageSize.height,
      );

      final image = heroImages[name];

      if (image != null) {
        paintImage(
          canvas: canvas,
          rect: imageRect,
          image: image,
          fit: BoxFit.fitHeight,
        );
      }

      canvas.restore();
      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) => true;
}
