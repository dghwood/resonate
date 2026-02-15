import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/subscription.dart';
import 'package:resonate/services/files/files.dart';

class OpmlComponent extends StatelessWidget {
  const OpmlComponent({super.key, required this.subscriptionApi});

  final SubscriptionApi subscriptionApi;

  void _pickFile(BuildContext context) async {
    try {
      final bytes = await FileService.pickOpmlFiles();
      if (bytes.isNotEmpty) {
        var result = await subscriptionApi.importOpml(bytes);
        switch (result) {
          case ApiOk():
            // Need to show a snackbar here on success
            ErrorService.instance.notify(context, 'Import successful');
            break;
          case ApiError():
            throw Exception(result.error);
        }
      }
    } on Exception catch (e) {
      ErrorService.instance.report(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.upload_file),
      title: const Text('Import OPML'),
      subtitle: const Text('Import your subscriptions from another app'),
      onTap: () => _pickFile(context),
    );
  }
}
