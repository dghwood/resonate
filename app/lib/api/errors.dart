import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ErrorService {
  ErrorService();

  SnackBar buildMessage(Exception error) {
    return SnackBar(content: Text('$error'));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
  _snackBarController;

  void report(BuildContext context, Exception error) {
    // TODO(duncan): Not sure this actually checks
    var scaffold = ScaffoldMessenger.maybeOf(context);
    if (scaffold == null) return;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Close any open snackbars
      scaffold.hideCurrentSnackBar();
      _snackBarController = scaffold.showSnackBar(buildMessage(error));
    });
  }
}
