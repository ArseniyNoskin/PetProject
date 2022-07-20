import 'package:new_project/data/models/heroInfoDTO.dart';
import 'package:new_project/presentation/form_submission_status.dart';

class HeroInfoState {
  DotaHero? hero;
  FormSubmissionStatus formStatus;

  HeroInfoState({this.hero, this.formStatus = const FormSubmitting()});
}
