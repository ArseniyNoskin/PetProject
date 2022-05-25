import 'package:new_project/data/models/heroesResponseDTO.dart';
import 'package:new_project/presentation/form_submission_status.dart';

class HeroInfoState {
  Heroes? hero;
  final FormSubmissionStatus formStatus;


  HeroInfoState({this.hero, this.formStatus = const InitialFormStatus()});
}
