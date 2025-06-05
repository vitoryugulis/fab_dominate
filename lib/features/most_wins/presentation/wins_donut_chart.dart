import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:dev/core/constants/app_colors.dart';
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

class _PlayersDonutChartState extends State<WinsDonutChart>
    with SingleTickerProviderStateMixin {
  final Map<String, ui.Image> heroImages = {};
  ui.Image? centerImage;
  Map<String, double> winsData = {};

  String? selectedHero;

  late AnimationController _controller;
  late CurvedAnimation _expandCurve;
  late CurvedAnimation _shrinkCurve;

  @override
  void initState() {
    super.initState();
    _loadAllHeroImages();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _expandCurve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _shrinkCurve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      final assetPath = YoungHeroImageMapper.getAssetPath(name.trim()) ?? '';

      final image = await _loadAssetImage(assetPath);
      if (image != null) {
        heroImages[name] = image;
      }
    }).toList();

    await Future.wait(futures);

    final center = await _loadAssetImage('lib/assets/high_seas.png');
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

  void _onTapDown(TapDownDetails details, Size size) {
    final localPosition = details.localPosition;
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final distanceFromCenter = sqrt(dx * dx + dy * dy);

    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.6;

    if (distanceFromCenter < innerRadius || distanceFromCenter > outerRadius) {
      setState(() {
        selectedHero = null;
      });
      _controller.reverse();
      return;
    }

    double angle = atan2(dy, dx) + pi / 2;
    if (angle < 0) angle += 2 * pi;

    double startAngle = 0;

    for (final entry in winsData.entries) {
      final sweepAngle =
          (entry.value / winsData.values.fold(0.0, (a, b) => a + b)) * 2 * pi;

      if (isAngleBetween(angle, startAngle, sweepAngle)) {
        setState(() {
          if (selectedHero == entry.key) {
            selectedHero = null;
            _controller.reverse();
          } else {
            selectedHero = entry.key;
            _controller.forward();
          }
        });
        return;
      }
      startAngle = (startAngle + sweepAngle) % (2 * pi);
    }

    setState(() {
      selectedHero = null;
    });
    _controller.reverse();
  }

  bool isAngleBetween(double angle, double start, double sweep) {
    final end = (start + sweep) % (2 * pi);
    if (start <= end) {
      return angle >= start && angle <= end;
    } else {
      return angle >= start || angle <= end;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalWins = winsData.values.fold(0.0, (a, b) => a + b);

    if (winsData.isEmpty || centerImage == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: AppColors.primaryLight,
      ));
    }

    final double minSize = OriginDevice.isMobileWeb() ? 100 : 370;
    final double maxSize = 230;

    final double centralLogoSize = !OriginDevice.isMobileWeb()
        ? max(maxSize, min(MediaQuery.of(context).size.width * 0.25, minSize))
        : MediaQuery.of(context).size.width * 0.55;

    final centralLogoTween = OriginDevice.isMobileWeb()
        ? Tween<double>(begin: 1.08, end: 0.98)
        : Tween<double>(begin: 1.2, end: 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return GestureDetector(
          onTapDown: (details) => _onTapDown(details, size),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final isExpanding = selectedHero != null &&
                        _controller.status != AnimationStatus.reverse;
                    final currentValue =
                        isExpanding ? _expandCurve.value : _shrinkCurve.value;

                    return CustomPaint(
                      size: Size.infinite,
                      painter: DonutChartPainter(
                        data: winsData,
                        totalWins: totalWins,
                        heroImages: heroImages,
                        selectedHero: selectedHero,
                        expansion: currentValue,
                      ),
                    );
                  },
                ),
                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: centralLogoTween,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: centralLogoSize,
                          height: centralLogoSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(150),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ],
                            image: DecorationImage(
                              image:
                                  const AssetImage('lib/assets/high_seas.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      );
                    },
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

class DonutChartPainter extends CustomPainter {
  final Map<String, double> data;
  final double totalWins;
  final Map<String, ui.Image> heroImages;
  final String? selectedHero;
  final double expansion; // Valor de 0.0 a 1.0

  DonutChartPainter({
    required this.data,
    required this.totalWins,
    required this.heroImages,
    this.selectedHero,
    this.expansion = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadiusBase = size.width / 2;
    final innerRadius = outerRadiusBase * 0.6;
    double startAngle = -pi / 2;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerRadiusBase * 0.08
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    final shadowPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: outerRadiusBase))
      ..addOval(Rect.fromCircle(center: center, radius: innerRadius))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(shadowPath, shadowPaint);

    data.forEach((name, wins) {
      final isSelected = name == selectedHero;
      final sweepAngle = (wins / totalWins) * 2 * pi;

      final outerRadius =
          isSelected ? outerRadiusBase + 20 * expansion : outerRadiusBase;

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
      final faceZoom = 12;

      final Offset focalPoint = YoungHeroImageMapper.getFocalPoint(name.trim());

      final double angleX = cos(middleAngle);
      final double angleY = sin(middleAngle);
      final double shiftIntensity = OriginDevice.isMobileWeb() ? 30 : 50;

      final sweepRatio = sweepAngle / (2 * pi);
      final zoomFactor = ui.lerpDouble(2, faceZoom, sweepRatio) ?? 2.0;

      final dynamicShift = shiftIntensity * sweepRatio;

      final offsetXDynamic = angleX * dynamicShift;
      final offsetYDynamic = angleY * dynamicShift;

      final imageSize = Size(
        (outerRadius - innerRadius) * zoomFactor,
        (outerRadius - innerRadius) * zoomFactor,
      );

      final focalOffset = calculateFocalOffset(focalPoint, imageSize);

      final imageCenter = Offset(
        center.dx + radius * cos(middleAngle) + offsetXDynamic + focalOffset.dx,
        center.dy + radius * sin(middleAngle) + offsetYDynamic + focalOffset.dy,
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
          fit: BoxFit.contain,
        );
      }

      canvas.restore();
      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) =>
      oldDelegate.data != data ||
      oldDelegate.selectedHero != selectedHero ||
      oldDelegate.expansion != expansion;
}

Offset calculateFocalOffset(Offset focalPoint, Size imageSize) {
  return Offset(
    focalPoint.dx * imageSize.width / 2,
    focalPoint.dy * imageSize.height / 2,
  );
}
