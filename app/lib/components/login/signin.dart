import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:logging/logging.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/result.dart';

/* Flow 

  1. User requests verification code 
  2. User enters verification code
  3. Done 
*/
Logger _log = Logger('SignInComponent');

class LoginInfo {
  String email = '';
  String verificationCode = '';
}

class SigninComponent2 extends StatefulWidget {
  SigninComponent2({super.key, required this.authUser});

  final AuthUser authUser;
  final LoginInfo loginInfo = LoginInfo();

  @override
  State<SigninComponent2> createState() => _SigninComponent2State();
}

class _SigninComponent2State extends State<SigninComponent2> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: Column(
              children: [
                Expanded(flex: 5, child: Center(child: Text('RESONATES'))),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: Text('LOGIN'),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SignInRequestComponent(
            pageController: _pageController,
            loginInfo: widget.loginInfo,
            authUser: widget.authUser,
          ),
          SignInValidateComponent(
            pageController: _pageController,
            loginInfo: widget.loginInfo,
            authUser: widget.authUser,
          ),
          // Consumer<AuthUser>(
          //   builder: (context, user, child) {
          //     if (!user.isSignedIn) return Text('NOT SIGNED IN');
          //     AbstractDatabaseService db = context.read();
          //     return FutureBuilder(
          //       future: db.init().then((_) => true),
          //       builder: (context, snapshot) {
          //         // _log.info(snapshot);
          //         if (snapshot.hasData) {
          //           // This is because I can't auto redirect this widget.
          //           return TextButton(
          //             onPressed: () => Navigate(context).toHome(),
          //             child: Text('ENTER'),
          //           );
          //         }
          //         return Scaffold(
          //           body: Center(child: CircularProgressIndicator()),
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class SignInRequestComponent extends StatefulWidget {
  const SignInRequestComponent({
    super.key,
    required this.authUser,
    required this.loginInfo,
    required PageController pageController,
  }) : _pageController = pageController;

  final LoginInfo loginInfo;
  final PageController _pageController;
  final AuthUser authUser;

  @override
  State<SignInRequestComponent> createState() => _SignInRequestComponentState();
}

class _SignInRequestComponentState extends State<SignInRequestComponent> {
  String _email = '';
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.loginInfo.email = _email;
      // This is async so you need a spinner
      widget.authUser.requestPassword(_email).then((result) {
        switch (result) {
          case ApiOk():
            if (!widget._pageController.hasClients) return;
            widget._pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          case ApiError():
            _log.info(result.error);
            break;
        }
      });
      // Handle sign-in logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Phone #'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!RegExp(r'^[\d\-]+$').hasMatch(value)) {
                  return 'Please enter a valid phone';
                }
                return null;
              },
              onSaved: (value) {
                _email = value ?? '';
              },
            ),
          ),

          TextButton(onPressed: _submit, child: Text('Sign In')),
        ],
      ),
    );
  }
}

class SignInValidateComponent extends StatefulWidget {
  const SignInValidateComponent({
    super.key,
    required this.loginInfo,
    required this.pageController,
    required this.authUser,
  });

  final AuthUser authUser;
  final PageController pageController;
  final LoginInfo loginInfo;

  @override
  State<SignInValidateComponent> createState() =>
      _SignInValidateComponentState();
}

class _SignInValidateComponentState extends State<SignInValidateComponent> {
  _SignInValidateComponentState();

  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Text(widget.loginInfo.email),
        VerificationCodeField(
          // placeholder: _value,
          autofocus: true,
          enabled: _enabled,
          length: 5,
          onFilled: (value) {
            _log.info('$value::${widget.loginInfo.email}');
            setState(() {
              _enabled = false;
            });
            widget.authUser.login(widget.loginInfo.email, value).then((result) {
              switch (result) {
                case ApiOk():
                  widget.pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  break;
                case ApiError():
                  _log.info(result.error);
              }
            });
          },
          spaceBetween: 16,
          matchingPattern: RegExp(r'^\d+$'),
        ),
        TextButton(onPressed: () {}, child: Text('Resend')),
      ],
    );
  }
}
