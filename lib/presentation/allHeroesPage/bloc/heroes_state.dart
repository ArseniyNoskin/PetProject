import 'package:new_project/data/models/heroesDTO.dart';
import 'package:new_project/presentation/form_submission_status.dart';

class HeroState {
  final List<DotaHero> heroList;
  final FormSubmissionStatus formStatus;

  HeroState({required this.heroList, this.formStatus = const InitialFormStatus()});
}
