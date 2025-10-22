import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/api/upload.dart';
import 'package:resonate/components/common/add_photo.dart';
import 'package:resonate/components/common/command.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/components/common/utils.dart';
import 'package:resonate/models/models.dart';

final Logger _log = Logger('tabs/pages/edit_profile');

class EditProfileComponent extends StatelessWidget {
  EditProfileComponent({
    super.key,
    required this.authUser,
    required this.uploadApi,
  }) {
    command = authUser.editCommand();
  }

  final AuthUser authUser;
  final formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final UploadApi uploadApi;
  late final ApiResultNotifier1<User, User> command;

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var name = nameEditingController.text;
      command.execute(User(name: name));
    }
  }

  void onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditableProfilePhotoComponent(
            onImageUpdated: (imageBytes) async {
              var result = await uploadApi.upload(imageBytes);
              switch (result) {
                case ApiOk():
                  var imageUrl = result.value;
                  command.execute(User(imageUrl: imageUrl));
                  return ApiResult.ok(true);
                case ApiError():
                  return ApiResult.error(result.error);
              }
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = authUser.user!;
    nameEditingController.text = user.name;

    Widget init(BuildContext context, {Exception? error}) {
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
              authUser.user?.imageUrl != ''
                  ? GestureDetector(
                    child: ImageComponent(
                      authUser.user!.imageUrl,
                      height: 250,
                      width: 250,
                      radius: 250,
                    ),
                    onTap: () => onPressed(context),
                  )
                  : IconButton(
                    icon: Icon(Icons.person),
                    iconSize: 150,
                    onPressed: () => onPressed(context),
                  ),
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
          onDone: (result) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
