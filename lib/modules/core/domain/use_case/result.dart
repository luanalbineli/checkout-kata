class Result<T> {
  Result.success(this.data)
      : type = ResultType.success,
        exception = null;

  Result.error(this.exception)
      : type = ResultType.error,
        data = null;

  final T? data;
  final dynamic exception;
  final ResultType type;

  bool get isSuccess => type == ResultType.success;

  bool get isError => type == ResultType.error;

  @override
  String toString() {
    if (isSuccess) {
      return 'SUCCESS - $data';
    }

    return 'ERROR - $exception';
  }
}

enum ResultType {
  success,
  error,
}
