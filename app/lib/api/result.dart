import 'dart:async';

enum ApiSource { local, server, both }

sealed class ApiResult<T> {
  const ApiResult();

  /// Creates a successful [Result], completed with the specified [value].
  const factory ApiResult.ok(T value) = ApiOk._;

  /// Creates an error [Result], completed with the specified [error].
  const factory ApiResult.error(Exception error) = ApiError._;
}

/// Subclass of Result for values
final class ApiOk<T> extends ApiResult<T> {
  const ApiOk._(this.value);

  /// Returned value in result
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors
final class ApiError<T> extends ApiResult<T> {
  const ApiError._(this.error);

  /// Returned error in result
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}

/* Iterable ApiResult */
sealed class IterableApiResult<T extends Iterable> {
  const IterableApiResult();
  // final ApiResult<T> result;
  // final Future<IterableApiResult<T>> Function()? next;

  const factory IterableApiResult.ok(
    T value, {
    Future<IterableApiResult<T>> Function()? next,
  }) = ApiOkIterable._;

  const factory IterableApiResult.error(Exception error) = ApiErrorIterable._;
}

final class ApiOkIterable<T extends Iterable> extends IterableApiResult<T> {
  const ApiOkIterable._(this.result, {this.next});

  final T result;
  final Future<IterableApiResult<T>> Function()? next;
}

final class ApiErrorIterable<T extends Iterable> extends IterableApiResult<T> {
  const ApiErrorIterable._(this.error);

  final Exception error;
}
