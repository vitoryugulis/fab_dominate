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
    HeroNames.verdance: ClassicHeroImages.verdance,
    HeroNames.enigma: ClassicHeroImages.enigma,
    HeroNames.nuu: ClassicHeroImages.nuu,
    HeroNames.zen: ClassicHeroImages.zen,
    HeroNames.betsy: ClassicHeroImages.betsy,
    HeroNames.kassai: ClassicHeroImages.kassai,
    HeroNames.kayo: ClassicHeroImages.kayo,
    HeroNames.olympia: ClassicHeroImages.olympia,
    HeroNames.victorDuplicate: ClassicHeroImages.victorGoldmane,
    HeroNames.maxx: ClassicHeroImages.maxx,
    HeroNames.prism: ClassicHeroImages.prism,
    HeroNames.vynnset: ClassicHeroImages.vynnset,
    HeroNames.riptide: ClassicHeroImages.riptide,
    HeroNames.rhinar: ClassicHeroImages.rhinar,
    HeroNames.dorinthea: ClassicHeroImages.dorinthea,
    HeroNames.azalea: ClassicHeroImages.azalea,
    HeroNames.kano: ClassicHeroImages.kano,
    // 🔥 Adicione outros conforme for necessário
  };

  static String? getImageUrl(String heroName) {
    return heroImageMap[heroName];
  }
}
