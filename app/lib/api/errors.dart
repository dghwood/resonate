import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:resonate/api/base.dart';
import 'package:resonate/proto/errors.pbenum.dart';

class ErrorService {
  ErrorService();

  SnackBar buildMessage(Exception error) {
    if (error is ApiException) {
      switch (error.errorEnum) {
        case ErrorEnum.ERROR_UPDATE_CLIENT_REQUIRED:
          return SnackBar(
            duration: Duration(hours: 24),
            // TODO(duncan): Link to app store to update
            // action: SnackBarAction(label: "Update", onPressed: () {
            //   // Open the app store, how do i do that?
            // }),
            content: Text("App is out of date, please update"),
          );
        default:
          break;
      }
    }
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
