import 'package:dev/core/constants/heroes/young_hero_assets.dart';
import 'package:dev/core/constants/heroes/young_hero_names.dart';

class YoungHeroImageMapper {
  static const Map<String, String> heroImageMap = {
    YoungHeroNames.araknisolitaire: YoungHeroAssets.araknisolitaire,
    YoungHeroNames.arakniweb: YoungHeroAssets.arakniweb,
    YoungHeroNames.aurora: YoungHeroAssets.aurora,
    YoungHeroNames.azalea: YoungHeroAssets.azalea,
    YoungHeroNames.benji: YoungHeroAssets.benji,
    YoungHeroNames.betsy: YoungHeroAssets.betsy,
    YoungHeroNames.boltyn: YoungHeroAssets.boltyn,
    YoungHeroNames.cindra: YoungHeroAssets.cindra,
    YoungHeroNames.dash: YoungHeroAssets.dash,
    YoungHeroNames.dashdatabase: YoungHeroAssets.dashdatabase,
    YoungHeroNames.datadoll: YoungHeroAssets.datadoll,
    YoungHeroNames.dori: YoungHeroAssets.dori,
    YoungHeroNames.doriProdigy: YoungHeroAssets.doriProdigy,
    YoungHeroNames.enigma: YoungHeroAssets.enigma,
    YoungHeroNames.fang: YoungHeroAssets.fang,
    YoungHeroNames.ira: YoungHeroAssets.ira,
    YoungHeroNames.kano: YoungHeroAssets.kano,
    YoungHeroNames.kassai: YoungHeroAssets.kassai,
    YoungHeroNames.kayo: YoungHeroAssets.kayo,
    YoungHeroNames.kayo2: YoungHeroAssets.kayo2,
    YoungHeroNames.levia: YoungHeroAssets.levia,
    YoungHeroNames.nuu: YoungHeroAssets.nuu,
    YoungHeroNames.olympia: YoungHeroAssets.olympia,
    YoungHeroNames.oscilio: YoungHeroAssets.oscilio,
    YoungHeroNames.rhinar: YoungHeroAssets.rhinar,
    YoungHeroNames.riptide: YoungHeroAssets.riptide,
    YoungHeroNames.shivana: YoungHeroAssets.shivana,
    YoungHeroNames.victor: YoungHeroAssets.victor,
    YoungHeroNames.visserai: YoungHeroAssets.visserai,
    YoungHeroNames.zen: YoungHeroAssets.zen,
    YoungHeroNames.chane: YoungHeroAssets.chane,
    YoungHeroNames.bravo: YoungHeroAssets.bravo,
    YoungHeroNames.fai: YoungHeroAssets.fai,
    YoungHeroNames.lexi: YoungHeroAssets.lexi,
    YoungHeroNames.verdance: YoungHeroAssets.verdance,
  };

  static String? getImageUrl(String heroName) {
    return heroImageMap[heroName];
  }
}
