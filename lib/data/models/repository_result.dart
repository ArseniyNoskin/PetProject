class RepositoryResult<T>{
  String? error;
  T success;

  RepositoryResult({required this.success, this.error});
}