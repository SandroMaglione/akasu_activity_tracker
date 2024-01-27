sealed class ApiError {
  const ApiError();
}

class QueryError extends ApiError {
  final Object error;
  final StackTrace stackTrace;
  const QueryError(this.error, this.stackTrace);
}
