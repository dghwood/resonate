/* ApiResultNotifier 

  This wrapper around ApiResults exposes a change notifier  
*/
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:resonate/api/result.dart';

typedef CommandAction0<T> = Future<ApiResult<T>> Function();
typedef CommandAction1<T, A> = Future<ApiResult<T>> Function(A);

enum ApiResultStatus { init, loading, done }

abstract class ApiResultNotifier<T> extends ChangeNotifier {
  ApiResultNotifier();

  ApiResultStatus _status = ApiResultStatus.init;
  ApiResultStatus get status => _status;

  ApiResult<T>? _result;
  ApiResult<T>? get result => _result;

  void clear() {
    _status = ApiResultStatus.init;
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_status == ApiResultStatus.loading || _status == ApiResultStatus.done) {
      return;
    }

    _status = ApiResultStatus.loading;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _status = ApiResultStatus.done;
      notifyListeners();
    }
  }
}

class ApiResultNotifier0<T> extends ApiResultNotifier<T> {
  ApiResultNotifier0(this._action);

  final CommandAction0<T> _action;

  /// Executes the action.
  Future<void> execute() async {
    await _execute(_action);
  }
}

class ApiResultNotifier1<T, A> extends ApiResultNotifier<T> {
  ApiResultNotifier1(this._action);

  final CommandAction1<T, A> _action;

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
