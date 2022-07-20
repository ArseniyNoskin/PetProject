import 'package:new_project/presentation/form_submission_status.dart';

import '../../../data/models/heroesResponseDTO.dart';

class HeroState {
  final List<Heroes> heroList;
  final FormSubmissionStatus formStatus;

  HeroState({required this.heroList, this.formStatus = const FormSubmitting()});
}
