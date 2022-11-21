class Result<T> {
  String? error;
  T? data;

  bool hasError;
  bool hasData = false;
  bool isEmpty = false;

  Result({
    this.error,
    this.data,
    this.hasError = false,
    this.hasData = false,
    this.isEmpty = false,
  });

  String get errorResult => error ?? (throw Exception('No error available'));
  T get dataResult => data ?? (throw Exception('No data available'));

  factory Result.error(String message) {
    return Result(
      error: message,
      hasError: true,
    );
  }

  factory Result.data(T data) {
    return Result(
      data: data,
      hasData: true,
    );
  }

  factory Result.empty() {
    return Result(
      isEmpty: true,
    );
  }
}
