import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dev/core/constants/classic_hero_images.dart';
import 'package:dev/core/constants/hero_image_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final proxyUrl = 'https://cors-anywhere.herokuapp.com/';

class PlayersDonutChart extends StatefulWidget {
  final List<List<String>> values;

  const PlayersDonutChart({super.key, required this.values});

  @override
  State<PlayersDonutChart> createState() => _PlayersDonutChartState();
}

class _PlayersDonutChartState extends State<PlayersDonutChart> {
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

    final center = await _loadAssetImage('lib/assets/fab.png');
    if (!mounted) return;
    setState(() {
      centerImage = center;
    });
  }

  /// 🔥 Função robusta para carregar imagem de rede
  Future<ui.Image?> _loadNetworkImage(String url) async {
    url = url.isEmpty ? ClassicHeroImages.other : url;
    try {
      Uint8List bytes;

      if (kIsWeb) {
        // 🔥 Web usa Dio diretamente
        final response = await Dio().get<List<int>>(
          url,
          options: Options(responseType: ResponseType.bytes),
        );
        bytes = Uint8List.fromList(response.data!);
      } else {
        // 🔥 Mobile/desktop podem usar NetworkAssetBundle ou Dio
        final uri = Uri.parse(url);
        final byteData = await NetworkAssetBundle(uri).load("");
        bytes = byteData.buffer.asUint8List();
      }

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

    // if (heroImages.length < data.length || centerImage == null) {
    //   return const Center(child: CircularProgressIndicator());
    // }

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
              width: 220,
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
                  image: const AssetImage('lib/assets/fab.png'),
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
      ..color = Colors.black.withOpacity(0.3)
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
