import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/components/common/command.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/models/models.dart';

final Logger _log = Logger('tabs/pages/edit_profile');

class EditProfileComponent extends StatelessWidget {
  EditProfileComponent({super.key, required this.authUser}) {
    command = authUser.editCommand();
  }

  final AuthUser authUser;
  final formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  late ApiResultNotifier1<User, User> command;

  void onSubmit() {
    _log.info('onSubmit');
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var name = nameEditingController.text;
      _log.info('name: $name');
      command.execute(User(name: name));
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = authUser.user!;
    nameEditingController.text = user.name;

    Widget init(BuildContext context, {Exception? error}) {
      _log.info('init::$error');
      if (error != null) {
        context.read<ErrorService>().report(context, error);
      }
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameEditingController,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: onSubmit)],
      ),
      body: Center(
        child: ApiResultNotifierComponent(
          init: init,
          command: command,
          loading: (_) => LoadingSpinnerComponent(),
          done: (context, result) => init(context),
        ),
      ),
    );
  }
}
