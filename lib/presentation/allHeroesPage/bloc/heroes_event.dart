abstract class HeroEvent{}

class ClickHero extends HeroEvent{}

class LoadAllHeroes extends HeroEvent{}

class GetSearchListHeroes extends HeroEvent{
  final String name;

  GetSearchListHeroes({this.name = ''});
}