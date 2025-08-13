import 'package:flutter/material.dart';

class ErrorService {
  ErrorService();

  SnackBar buildMessage(Exception error) {
    return SnackBar(content: Text('$error'));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
  _snackBarController;

  Future<void> report(BuildContext context, Exception error) async {
    var scaffold = ScaffoldMessenger.of(context);
    // Close any open snackbars
    scaffold.hideCurrentSnackBar();
    _snackBarController = scaffold.showSnackBar(buildMessage(error));
  }
}
