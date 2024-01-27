sealed class ApiError {
  const ApiError();

  @override
  String toString() {
    return "Unexpected error!";
  }
}

class QueryError extends ApiError {
  final Object error;
  final StackTrace stackTrace;
  const QueryError(this.error, this.stackTrace);

  @override
  String toString() {
    return "Query error: $error";
  }
}
