import 'package:dev/core/constants/heroes/adult_hero_assets.dart';
import 'package:dev/core/constants/heroes/adult_hero_names.dart';

class AdultHeroImageMapper {
  static const Map<String, String> heroImageMap = {
    AdultHeroNames.cindra: AdultHeroAssets.cindra,
    AdultHeroNames.fang: AdultHeroAssets.fang,
    AdultHeroNames.arakniMarionette: AdultHeroAssets.arakni,
    AdultHeroNames.arakniGlitched: AdultHeroAssets.slippy,
    AdultHeroNames.jarl: AdultHeroAssets.jarl,
    AdultHeroNames.aurora: AdultHeroAssets.aurora,
    AdultHeroNames.oscilio: AdultHeroAssets.oscilio,
    AdultHeroNames.verdanceThorn: AdultHeroAssets.verdance,
    AdultHeroNames.enigmaLedger: AdultHeroAssets.enigma,
    AdultHeroNames.nuu: AdultHeroAssets.nuu,
    AdultHeroNames.zen: AdultHeroAssets.zen,
    AdultHeroNames.betsy: AdultHeroAssets.betsy,
    AdultHeroNames.kassaiGolden: AdultHeroAssets.kassai,
    AdultHeroNames.kayoArmed: AdultHeroAssets.kayo,
    AdultHeroNames.olympia: AdultHeroAssets.olympia,
    AdultHeroNames.victorDuplicate: AdultHeroAssets.victorGoldmane,
    AdultHeroNames.maxx: AdultHeroAssets.maxx,
    AdultHeroNames.prism: AdultHeroAssets.prism,
    AdultHeroNames.vynnset: AdultHeroAssets.vynnset,
    AdultHeroNames.riptide: AdultHeroAssets.riptide,
    AdultHeroNames.rhinarReckless: AdultHeroAssets.rhinar,
    AdultHeroNames.dorintheaIronsong: AdultHeroAssets.dorinthea,
    AdultHeroNames.azalea: AdultHeroAssets.azalea,
    AdultHeroNames.kanoDracai: AdultHeroAssets.kano,
    AdultHeroNames.iraScarlet: AdultHeroAssets.ira,
    AdultHeroNames.florian: AdultHeroAssets.florian,
    AdultHeroNames.fangDracai: AdultHeroAssets.fang,
    AdultHeroNames.viserai: AdultHeroAssets.viserai,
    AdultHeroNames.dashIO: AdultHeroAssets.dash,
    AdultHeroNames.leviaShadow: AdultHeroAssets.levia,
  };

  static String? getImageUrl(String heroName) {
    return heroImageMap[heroName];
  }
}
