abstract class HeroInfoEvent{}

class LoadingScreen extends HeroInfoEvent{
  final int id;

  LoadingScreen(this.id);
}