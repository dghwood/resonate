import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/api/errors.dart';
import 'package:resonate/api/result.dart';
import 'package:resonate/components/common/command.dart';
import 'package:resonate/components/common/loading.dart';

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
    var user = context.read<AuthUser>();
    return Scaffold(
      body: PageView(
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
          SignInRequestFlowComponent(
            command: user.requestPasswordCommand(),
            loginInfo: widget.loginInfo,
            pageController: _pageController,
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

class SignInRequestFlowComponent extends StatelessWidget {
  const SignInRequestFlowComponent({
    super.key,
    required this.loginInfo,
    required this.pageController,
    required this.command,
  });

  final LoginInfo loginInfo;
  final ApiResultNotifier1<bool, String> command;
  final PageController pageController;

  Widget _init(BuildContext context, {Exception? error}) {
    if (error != null) {
      _log.info(error);
      // var scaffold = ScaffoldMessenger.of(context);
      // _log.info(scaffold);
      // // scaffold.hideCurrentSnackBar();
      // scaffold.showSnackBar(SnackBar(content: Text('$error')));
      context.read<ErrorService>().report(context, error);
    }
    return SignInRequestComponent(command: command, loginInfo: loginInfo);
  }

  Widget _done(BuildContext context, bool result) {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    return _init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ApiResultNotifierComponent<bool>(
      command: command,
      init: _init,
      loading: (_) => LoadingSpinnerComponent(),
      done: _done,
    );
  }
}

class SignInRequestComponent extends StatefulWidget {
  const SignInRequestComponent({
    super.key,
    required this.loginInfo,
    required ApiResultNotifier1<bool, String> command,
  }) : _command = command;

  final LoginInfo loginInfo;
  final ApiResultNotifier1<bool, String> _command;

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
      widget._command.execute(_email);
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
                  _log.info('logged in, hopefully this redirects');
                  // widget.pageController.nextPage(
                  //   duration: Duration(milliseconds: 500),
                  //   curve: Curves.easeInOut,
                  // );
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
