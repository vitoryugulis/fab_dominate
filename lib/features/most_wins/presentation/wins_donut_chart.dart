import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:dev/core/constants/heroes/classic_hero_images.dart';
import 'package:dev/core/constants/heroes/hero_image_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class WinsDonutChart extends StatefulWidget {
  final List<List<String>> values;

  const WinsDonutChart({super.key, required this.values});

  @override
  State<WinsDonutChart> createState() => _PlayersDonutChartState();
}

class _PlayersDonutChartState extends State<WinsDonutChart> {
  final Map<String, ui.Image> heroImages = {};
  ui.Image? centerImage;

  @override
  void initState() {
    super.initState();
    _loadAllHeroImages();
  }

  Future<void> _loadAllHeroImages() async {
    final futures = widget.values.map((row) async {
      final name = row.isNotEmpty ? row[0] : 'Unknown';
      final imageUrl = HeroImageMapper.getImageUrl(name);

      final image = await _loadNetworkImage(imageUrl ?? '');
      if (image != null) {
        heroImages[name] = image;
      }
    }).toList();

    await Future.wait(futures);

    final center = await _loadAssetImage('lib/assets/fab.jpg');
    if (!mounted) return;
    setState(() {
      centerImage = center;
    });
  }

  /// 🔥 Função robusta para carregar imagem de rede
  Future<ui.Image?> _loadNetworkImage(String url) async {
    url = url.isEmpty ? ClassicHeroImages.other : url;
    try {
      final file = await DefaultCacheManager().getSingleFile(url);
      final bytes = await file.readAsBytes();

      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      return frame.image;
    } catch (e) {
      debugPrint('Erro ao carregar imagem da url $url: $e');
      return null;
    }
  }

  /// 🔥 Carregar imagem de asset
  Future<ui.Image?> _loadAssetImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
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

    if (data.isEmpty || centerImage == null) {
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
              heroImages: heroImages,
            ),
          ),
          Center(
            child: Container(
              width: 380,
              height: 380,
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
  final List<Map<String, dynamic>> data;
  final int totalWins;
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

    for (var item in data) {
      final name = item['name'] as String;
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
      final offsetY = 40.0;

      final imageCenter = Offset(
        center.dx + radius * cos(middleAngle),
        center.dy + radius * sin(middleAngle) + offsetY,
      );
      final sweepRatio = sweepAngle / (2 * pi);
      final zoomFactor = ui.lerpDouble(1.8, 2.9, sweepRatio) ?? 2.0;

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
          fit: BoxFit.cover,
        );
      }

      canvas.restore();
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) => true;
}
