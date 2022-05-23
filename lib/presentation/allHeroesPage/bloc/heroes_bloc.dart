import 'package:bloc/bloc.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_event.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_state.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import '../../../data/repository/dota_repository.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final DotaRepository? dotaRepository;



  HeroBloc({this.dotaRepository}) : super(HeroState(heroList: [])){
    on<ClickHero>((event, emit) {

    });

    on<LoadAllHeroes>((event, emit) async{
      var result = await dotaRepository?.fetchAllHeroes();

      if (result!.error == null){
        print('repo res success= ${result.success}');
        emit(HeroState(heroList: result.success, formStatus: SubmissionSuccess()));
      }else{
        print('repo res error= ${result.error}');
        emit(HeroState(heroList: result.success, formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }
}