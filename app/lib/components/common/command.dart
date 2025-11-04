import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';

final Logger _log = Logger('components/common/command');

class ApiResultNotifierComponent<T> extends StatelessWidget {
  const ApiResultNotifierComponent({
    super.key,
    required ApiResultNotifier<T> command,
    required this.init,
    required this.loading,
    required this.done,
    this.onDone,
  }) : _command = command;

  final ApiResultNotifier<T> _command;
  final Widget Function(BuildContext context, {Exception? error}) init;
  final Widget Function(BuildContext context) loading;
  final Widget Function(BuildContext context, T result) done;
  final void Function(T result)? onDone;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _command,
      builder: (context, _) {
        _log.info('command status:: ${_command.status}');
        switch (_command.status) {
          case ApiResultStatus.init:
            return init(context);
          case ApiResultStatus.loading:
            return loading(context);
          case ApiResultStatus.done:
            var result = _command.result;
            switch (result) {
              case ApiOk():
                if (onDone != null) {
                  // Is this a hack?
                  SchedulerBinding.instance.addPostFrameCallback(
                    (_) => onDone!(result.value),
                  );
                }
                return done(context, result.value);
              case ApiError():
                _command.clear();
                // Report the error
                context.read<ErrorService>().report(context, result.error);
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
