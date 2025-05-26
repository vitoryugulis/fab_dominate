#!/bin/zsh

# Diretório de destino na mesa
DEST_DIR="$HOME/Desktop/ClassicHeroImages"

# Criar o diretório se não existir
mkdir -p "$DEST_DIR"

# Lista de URLs e nomes de arquivos
urls=(
  "cindra_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/cindra_cover.width-10000.format-webp.webp"
  "fang_story.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/fang_story_1_Qw4CBaj.width-10000.format-webp.webp"
  "chaos_story.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/chaos_story_1_74JOzBs.width-10000.format-webp.webp"
  "slippy_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/slippy_cover.width-10000.format-webp.webp"
  "sea_preview_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/sea_preview_cover.width-10000.format-webp.webp"
  "jarl_art.jpg=https://dhhim4ltzu1pj.cloudfront.net/media/images/ad-origins_jarl_art.original.jpg"
  "aurora_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/aurora_cover.width-10000.format-webp.webp"
  "florian_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/florian_cover.width-10000.format-webp.webp"
  "oscilio_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/oscilio_cover.width-10000.format-webp.webp"
  "verdance_cover.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/verdance_cover.width-10000.format-webp.webp"
  "enigma_wide.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/enigma_wide.width-10000.format-webp.webp"
  "nuu_wide.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/nuu_wide.width-10000.format-webp.webp"
  "mst_spoilers.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/mst_spoilers_2_66bJHBT.width-10000.format-webp.webp"
  "betsy.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/hvy_titlescreen_betsy.width-10000.format-webp.webp"
  "kassai.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/hvy_titlescreen_kassai_of_the_g.width-10000.format-webp.webp"
  "kayo.jpeg=https://cdn.cardsrealm.com/images/cartas/hvy-heavy-hitters/EN/crop-med/kayo-armed-and-dangerous-hvy001.jpeg?3333"
  "olympia.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/hvy_titlescreen_olympia.width-10000.format-webp.webp"
  "victor.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/hvy_titlescreen_victor.width-10000.format-webp.webp"
  "dash.jpg=https://i.etsystatic.com/43401833/r/il/46846f/5370237414/il_1080xN.5370237414_c42m.jpg"
  "moonshot.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/M-BOOST_Moonshot_JessadaSutthi.width-992.format-webp.webp"
  "prism.jpg=https://mktg-assets.tcgplayer.com/content/opengraph/FAB-Prism-Awakener-of-Sol-DTD.jpg"
  "vynnset.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/SHADOW-RUNEBLADE_HERO_Vynnset_Iro.width-992.format-webp.webp"
  "riptide.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/riptide.width-992.format-webp.webp"
  "boltyn.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/bol_main_hero_image_001.width-992.format-webp.webp"
  "levia.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/Wisnu_Tan_-_Levia_Shadowborn_Abom.width-992.format-webp.webp"
  "azalea.webp=https://dhhim4ltzu1pj.cloudfront.net/media/images/azalea.width-992.format-webp.webp"
  "kano.png=https://www.cardtrader.com/uploads/blueprints/image/218176/show_kano-dracai-of-aether-marvel-history-pack-1-black-label.png"
  "viserai.jpg=https://fabmeta.net/web_data/images/heroes/avatar/viserai.jpg"
  "dorinthea.png=https://www.cardtrader.com/uploads/blueprints/image/218174/show_dorinthea-ironsong-marvel-history-pack-1-black-label.png"
  "rhinar.jpg=https://www.cardtrader.com/uploads/blueprints/image/218177/rhinar-reckless-rampage-marvel-history-pack-1-black-label.jpg"
  "ira.jpg=https://files.dragonshield.com/fab/artcrop/8901.jpg"
)

# Baixar cada URL com nome especificado
for entry in "${urls[@]}"; do
  file_name="${entry%%=*}"
  url="${entry#*=}"
  echo "Baixando $url como $file_name..."
  curl -o "$DEST_DIR/$file_name" "$url"
done

echo "Download concluído. Imagens salvas em $DEST_DIR."