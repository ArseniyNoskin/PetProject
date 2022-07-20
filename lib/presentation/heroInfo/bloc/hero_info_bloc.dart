import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/data/repository/dota_repository.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_event.dart';
import 'package:new_project/presentation/heroInfo/bloc/hero_info_state.dart';

class HeroInfoBloc extends Bloc<HeroInfoEvent, HeroInfoState> {
  final DotaRepository? dotaRepository;

  HeroInfoBloc({this.dotaRepository}) : super(HeroInfoState(hero: null)){
    on<LoadingScreen>((event, emit) async {
      var result = await dotaRepository?.fetchHeroById(event.id);

      if (result!.error == null){
        emit(HeroInfoState(hero: result.success, formStatus: SubmissionSuccess()));
      }else{
        emit(HeroInfoState(hero: result.success, formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }
}