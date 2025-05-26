import 'package:dev/core/constants/heroes/classic_hero_assets.dart';
import 'package:dev/core/constants/heroes/hero_names.dart';

class HeroImageMapper {
  static const Map<String, String> heroImageMap = {
    HeroNames.cindra: ClassicHeroAssets.cindra,
    HeroNames.fang: ClassicHeroAssets.fang,
    HeroNames.arakniMarionette: ClassicHeroAssets.arakni,
    HeroNames.arakniGlitched: ClassicHeroAssets.slippy,
    HeroNames.jarl: ClassicHeroAssets.jarl,
    HeroNames.aurora: ClassicHeroAssets.aurora,
    HeroNames.oscilio: ClassicHeroAssets.oscilio,
    HeroNames.verdanceThorn: ClassicHeroAssets.verdance,
    HeroNames.enigmaLedger: ClassicHeroAssets.enigma,
    HeroNames.nuu: ClassicHeroAssets.nuu,
    HeroNames.zen: ClassicHeroAssets.zen,
    HeroNames.betsy: ClassicHeroAssets.betsy,
    HeroNames.kassaiGolden: ClassicHeroAssets.kassai,
    HeroNames.kayoArmed: ClassicHeroAssets.kayo,
    HeroNames.olympia: ClassicHeroAssets.olympia,
    HeroNames.victorDuplicate: ClassicHeroAssets.victorGoldmane,
    HeroNames.maxx: ClassicHeroAssets.maxx,
    HeroNames.prism: ClassicHeroAssets.prism,
    HeroNames.vynnset: ClassicHeroAssets.vynnset,
    HeroNames.riptide: ClassicHeroAssets.riptide,
    HeroNames.rhinarReckless: ClassicHeroAssets.rhinar,
    HeroNames.dorintheaIronsong: ClassicHeroAssets.dorinthea,
    HeroNames.azalea: ClassicHeroAssets.azalea,
    HeroNames.kanoDracai: ClassicHeroAssets.kano,
    HeroNames.iraScarlet: ClassicHeroAssets.ira,
    HeroNames.florian: ClassicHeroAssets.florian,
    HeroNames.fangDracai: ClassicHeroAssets.fang,
    HeroNames.viserai: ClassicHeroAssets.viserai,
    HeroNames.dashIO: ClassicHeroAssets.dash,
    HeroNames.leviaShadow: ClassicHeroAssets.levia,
  };

  static String? getImageUrl(String heroName) {
    return heroImageMap[heroName];
  }
}
