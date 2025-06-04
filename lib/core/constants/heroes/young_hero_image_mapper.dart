import 'dart:ui';

import 'package:dev/core/constants/heroes/young_hero_assets.dart';
import 'package:dev/core/constants/heroes/young_hero_names.dart';

class HeroAssetData {
  final String assetPath;
  final Offset focalPoint; // -1 até 1, onde (0, 0) é o centro

  const HeroAssetData({
    required this.assetPath,
    this.focalPoint = const Offset(0, 0.4),
  });
}

class YoungHeroImageMapper {
  static const Map<String, HeroAssetData> heroImageMap = {
    YoungHeroNames.araknisolitaire: HeroAssetData(
      assetPath: YoungHeroAssets.araknisolitaire,
        focalPoint: Offset(0.2, 0.1)
    ),
    YoungHeroNames.arakniweb: HeroAssetData(
      assetPath: YoungHeroAssets.arakniweb,
      focalPoint: Offset(0.3, 0.2)
    ),
    YoungHeroNames.aurora: HeroAssetData(
      assetPath: YoungHeroAssets.aurora2,
      focalPoint: Offset(0.1, 0.3),
    ),
    YoungHeroNames.azalea: HeroAssetData(
      assetPath: YoungHeroAssets.azalea,
    ),
    YoungHeroNames.benji: HeroAssetData(
      assetPath: YoungHeroAssets.benji,
      focalPoint: Offset(0, -0.25),
    ),
    YoungHeroNames.betsy: HeroAssetData(
      assetPath: YoungHeroAssets.betsy,
    ),
    YoungHeroNames.boltyn: HeroAssetData(
      assetPath: YoungHeroAssets.boltyn,
      focalPoint: Offset(0, -0.15),
    ),
    YoungHeroNames.cindra: HeroAssetData(
      assetPath: YoungHeroAssets.cindra,
    ),
    YoungHeroNames.dash: HeroAssetData(
      assetPath: YoungHeroAssets.dash,
      focalPoint: Offset(-0.3, 0.40)
    ),
    YoungHeroNames.dashdatabase: HeroAssetData(
      assetPath: YoungHeroAssets.dashdatabase,
    ),
    YoungHeroNames.datadoll: HeroAssetData(
      assetPath: YoungHeroAssets.datadoll,
    ),
    YoungHeroNames.dori: HeroAssetData(
      assetPath: YoungHeroAssets.dori,
    ),
    YoungHeroNames.doriProdigy: HeroAssetData(
      assetPath: YoungHeroAssets.doriProdigy,
    ),
    YoungHeroNames.enigma: HeroAssetData(
      assetPath: YoungHeroAssets.enigma,
      focalPoint: Offset(0.1, 0.2),
    ),
    YoungHeroNames.fang: HeroAssetData(
      assetPath: YoungHeroAssets.fang,
    ),
    YoungHeroNames.ira: HeroAssetData(
      assetPath: YoungHeroAssets.ira,
      focalPoint: Offset(-0.1, 0.4)
    ),
    YoungHeroNames.kano: HeroAssetData(
      assetPath: YoungHeroAssets.kano,
    ),
    YoungHeroNames.kassai: HeroAssetData(
      assetPath: YoungHeroAssets.kassai,
    ),
    YoungHeroNames.kayo: HeroAssetData(
      assetPath: YoungHeroAssets.kayo,
    ),
    YoungHeroNames.kayo2: HeroAssetData(
      assetPath: YoungHeroAssets.kayo2,
    ),
    YoungHeroNames.levia: HeroAssetData(
      assetPath: YoungHeroAssets.levia,
    ),
    YoungHeroNames.nuu: HeroAssetData(
      assetPath: YoungHeroAssets.nuu,
    ),
    YoungHeroNames.olympia: HeroAssetData(
      assetPath: YoungHeroAssets.olympia,
      focalPoint: Offset(-0.1, 0.5),
    ),
    YoungHeroNames.oscilio: HeroAssetData(
      assetPath: YoungHeroAssets.oscilio,
    ),
    YoungHeroNames.rhinar: HeroAssetData(
      assetPath: YoungHeroAssets.rhinar,
    ),
    YoungHeroNames.riptide: HeroAssetData(
      assetPath: YoungHeroAssets.riptide,
      focalPoint: Offset(0, -0.25),
    ),
    YoungHeroNames.shivana: HeroAssetData(
      assetPath: YoungHeroAssets.shivana,
    ),
    YoungHeroNames.victor: HeroAssetData(
      assetPath: YoungHeroAssets.victor,
    ),
    YoungHeroNames.visserai: HeroAssetData(
      assetPath: YoungHeroAssets.visserai,
    ),
    YoungHeroNames.zen: HeroAssetData(
      assetPath: YoungHeroAssets.zen,
    ),
    YoungHeroNames.chane: HeroAssetData(
      assetPath: YoungHeroAssets.chane,
      focalPoint: Offset(0, 0.0),
    ),
    YoungHeroNames.bravo: HeroAssetData(
      assetPath: YoungHeroAssets.bravo,
    ),
    YoungHeroNames.fai: HeroAssetData(
      assetPath: YoungHeroAssets.fai,
    ),
    YoungHeroNames.lexi: HeroAssetData(
      assetPath: YoungHeroAssets.lexi,
    ),
    YoungHeroNames.verdance: HeroAssetData(
      assetPath: YoungHeroAssets.verdance,
    ),
  };

  static HeroAssetData? getHeroAsset(String heroName) {
    return heroImageMap[heroName];
  }

  static String? getAssetPath(String heroName) {
    return heroImageMap[heroName]?.assetPath;
  }

  static Offset getFocalPoint(String heroName) {
    return heroImageMap[heroName]?.focalPoint ?? Offset.zero;
  }
}