import 'package:dev/core/constants/classic_hero_images.dart';
import 'package:dev/core/constants/hero_names.dart';

class HeroImageMapper {
  static const Map<String, String> heroImageMap = {
    HeroNames.cindra: ClassicHeroImages.cindra,
    HeroNames.fang: ClassicHeroImages.fang,
    HeroNames.arakniMarionette: ClassicHeroImages.arakni,
    HeroNames.arakniGlitched: ClassicHeroImages.slippy,
    HeroNames.jarl: ClassicHeroImages.jarl,
    HeroNames.aurora: ClassicHeroImages.aurora,
    HeroNames.oscilio: ClassicHeroImages.oscilio,
    HeroNames.verdanceThorn: ClassicHeroImages.verdance,
    HeroNames.enigma: ClassicHeroImages.enigma,
    HeroNames.nuu: ClassicHeroImages.nuu,
    HeroNames.zen: ClassicHeroImages.zen,
    HeroNames.betsy: ClassicHeroImages.betsy,
    HeroNames.kassai: ClassicHeroImages.kassai,
    HeroNames.kayoArmed: ClassicHeroImages.kayo,
    HeroNames.olympia: ClassicHeroImages.olympia,
    HeroNames.victorDuplicate: ClassicHeroImages.victorGoldmane,
    HeroNames.maxx: ClassicHeroImages.maxx,
    HeroNames.prism: ClassicHeroImages.prism,
    HeroNames.vynnset: ClassicHeroImages.vynnset,
    HeroNames.riptide: ClassicHeroImages.riptide,
    HeroNames.rhinarReckless: ClassicHeroImages.rhinar,
    HeroNames.dorinthea: ClassicHeroImages.dorinthea,
    HeroNames.azalea: ClassicHeroImages.azalea,
    HeroNames.kanoDracai: ClassicHeroImages.kano,
    HeroNames.iraScarlet: ClassicHeroImages.ira,
    HeroNames.florian: ClassicHeroImages.florian,
    HeroNames.fangDracai: ClassicHeroImages.fang,
    HeroNames.viserai: ClassicHeroImages.viserai,
    HeroNames.dashIO: ClassicHeroImages.dash,
    HeroNames.levia: ClassicHeroImages.levia,
  };

  static String? getImageUrl(String heroName) {
    return heroImageMap[heroName];
  }
}
