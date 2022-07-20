abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus{
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus{
  const FormSubmitting();
}

class SubmissionSuccess extends FormSubmissionStatus{}

class SubmissionFailed extends FormSubmissionStatus{
  final Exception exception;

  SubmissionFailed(this.exception);
}
