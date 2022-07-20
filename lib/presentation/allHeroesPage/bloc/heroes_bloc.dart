import 'package:bloc/bloc.dart';
import 'package:new_project/data/models/heroesResponseDTO.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_event.dart';
import 'package:new_project/presentation/allHeroesPage/bloc/heroes_state.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import '../../../data/repository/dota_repository.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final DotaRepository? dotaRepository;

  List<Heroes>? listAllHero = null;

  HeroBloc({this.dotaRepository}) : super(HeroState(heroList: [])) {
    on<LoadAllHeroes>((event, emit) async {

      if(listAllHero != null){
        return;
      }

      var result = await dotaRepository?.fetchAllHeroes();
      if (result!.error == null) {
        listAllHero = result.success;
        emit(HeroState(heroList: result.success, formStatus: SubmissionSuccess()));
      } else {
        emit(HeroState(heroList: result.success, formStatus: SubmissionFailed(Exception(result.error))));
      }
    });

    on<GetSearchListHeroes>((event, emit) async {
      var filteredList =
          listAllHero?.where((element) => element.nameLoc!.toLowerCase().contains(event.name.toLowerCase())).toList() ??
              List.empty();
      emit(HeroState(heroList: filteredList, formStatus: SubmissionSuccess()));
    });
  }
}
