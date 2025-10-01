import 'dart:async';

import 'package:flutter/material.dart';

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

// Stream Api Result
class StreamApiResult<P extends ApiResult, R extends ApiResult> {
  StreamApiResult() {
    _progressController = StreamController<P>(
      onCancel: () {},
      onListen: () {},
      onPause: () {},
      onResume: () {},
    );
    _doneController = StreamController<R>(
      onCancel: () {},
      onListen: () {},
      onPause: () {},
      onResume: () {},
    );
  }

  late final StreamController<P> _progressController;
  Stream<P> get progress => _progressController.stream;
  late final StreamController<R> _doneController;
  Future<R> get done => _doneController.stream.first;
}
