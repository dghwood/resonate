import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';

final Logger _log = Logger('tabs/pages/edit_profile');

class EditProfileComponent extends StatelessWidget {
  EditProfileComponent({super.key, required this.authUser});

  final AuthUser authUser;
  final formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var name = nameEditingController.text;
      _log.info('name: $name');
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = authUser.user!;
    nameEditingController.text = user.name;

    return Scaffold(
      appBar: AppBar(title: Text('Edit profile')),
      body: Center(
        child: Form(
          // onChanged: () {
          //   if (formKey.currentState!.validate()) {
          //     formKey.currentState!.save();
          //   }
          // },
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameEditingController,
                  // initialValue: user.name,
                  decoration: InputDecoration(labelText: 'Name'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    return null;
                  },
                  // TODO(duncan): Set a max length?
                  maxLength: 256,
                  onSaved: (value) {
                    _log.info('name: $value');
                  },
                ),

                TextFormField(
                  initialValue: user.phoneNumber,
                  decoration: InputDecoration(labelText: 'Phone #'),
                  keyboardType: TextInputType.phone,
                  readOnly: true,
                  validator: (value) {
                    return null;
                  },
                  // TODO(duncan): Set a max length?
                  // maxLength: 100,
                  // onSaved: (value) {
                  //   _log.info('name: $value');
                  // },
                ),

                TextButton(onPressed: onSubmit, child: Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
