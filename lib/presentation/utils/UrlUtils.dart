import 'package:new_project/data/models/heroAbilities.dart';

class UrlUtils {
  var baseUrl = 'https://cdn.cloudflare.steamstatic.com/apps/dota2';

  String getHeroUrl(String nameHero) {
    return '$baseUrl/images/dota_react/heroes/${nameHero.replaceAll('npc_dota_hero_', '')}.png';
  }

  String getHeroAbilityVideoUrl(String nameHero, Ability ability) {
    if (ability.abilityIsGrantedByScepter == true) {
      return '$baseUrl/videos/dota_react/abilities/${nameHero.toLowerCase()}/${nameHero.toLowerCase()}_aghanims_scepter.webm';
    } else if (ability.abilityIsGrantedByShard == true) {
      return '$baseUrl/videos/dota_react/abilities/${nameHero.toLowerCase()}/${nameHero.toLowerCase()}_aghanims_shard.webm';
    } else {
      return '$baseUrl/videos/dota_react/abilities/${nameHero.toLowerCase()}/${ability.name}.webm';
    }
  }
}
