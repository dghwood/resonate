import 'package:flutter/material.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/api/result.dart';

class ApiResultNotifierComponent<T> extends StatelessWidget {
  const ApiResultNotifierComponent({
    super.key,
    required ApiResultNotifier<T> command,
    required this.init,
    required this.loading,
    required this.done,
  }) : _command = command;

  final ApiResultNotifier<T> _command;
  final Widget Function(BuildContext context, {Exception? error}) init;
  final Widget Function(BuildContext context) loading;
  final Widget Function(BuildContext context, T result) done;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _command,
      builder: (context, _) {
        switch (_command.status) {
          case ApiResultStatus.init:
            return init(context);
          case ApiResultStatus.loading:
            return loading(context);
          case ApiResultStatus.done:
            var result = _command.result;
            switch (result) {
              case ApiOk():
                return done(context, result.value);
              case ApiError():
                _command.clear();
                // TODO(duncan): report the error to the error service here?
                return init(context, error: result.error);
              default:
                _command.clear();
                // TODO(duncan): This shouldn't happen
                return init(
                  context,
                  error: Exception("Something really went wrong"),
                );
            }
        }
      },
    );
  }
}
