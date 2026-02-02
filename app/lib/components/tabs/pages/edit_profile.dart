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
import 'package:resonate/router/navigation.dart';

final Logger _log = Logger('tabs/pages/edit_profile');

class EditProfileComponent extends StatefulWidget {
  EditProfileComponent({
    super.key,
    required this.authUser,
    required this.uploadApi,
    this.onDone,
  }) {
    command = authUser.editCommand();
  }

  final AuthUser authUser;
  final UploadApi uploadApi;
  final Function(User user)? onDone;
  late final ApiResultNotifier1<User, User> command;

  @override
  State<EditProfileComponent> createState() => _EditProfileComponentState();
}

class _EditProfileComponentState extends State<EditProfileComponent> {
  final formKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var name = nameEditingController.text;
      // if newImageUrl is null it won't update the image.
      widget.command.execute(User(name: name.trim(), imageUrl: newImageUrl));
    }
  }

  String? newImageUrl;

  void onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditableProfilePhotoComponent(
            onImageUpdated: (imageBytes) async {
              var result = await widget.uploadApi.upload(imageBytes);
              switch (result) {
                case ApiOk():
                  // var imageUrl = result.value;
                  _log.info("image url length: ${result.value.length}");
                  setState(() {
                    newImageUrl = result.value;
                  });
                  // I actually want to move this
                  // widget.command.execute(User(imageUrl: imageUrl));
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

  Widget init(BuildContext context, {Exception? error}) {
    if (error != null) {
      context.read<ErrorService>().report(context, error);
    }
    var imageUrl = newImageUrl ?? widget.authUser.user?.imageUrl;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl != null && imageUrl != ''
                ? InkWell(
                  child: ImageComponent(
                    imageUrl,
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
              maxLength: 64,
              controller: nameEditingController,
              decoration: InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.authUser.user!;
    nameEditingController.text = user.name;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        actions: [IconButton(icon: Icon(Icons.check), onPressed: onSubmit)],
      ),
      body: Center(
        child: ApiResultNotifierComponent(
          init: init,
          command: widget.command,
          loading: (_) => LoadingSpinnerComponent(),
          done: (context, result) => init(context),
          onDone: (result) {
            if (widget.onDone != null) {
              widget.command.clear();
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigate(context).toProfilePage();
            }
          },
        ),
      ),
    );
  }
}
