import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:resonate/api/auth.dart';
import 'package:resonate/api/command.dart';
import 'package:resonate/components/common/command.dart';
import 'package:resonate/components/common/loading.dart';
import 'package:resonate/router/navigation.dart';

/* Flow 

  1. User requests verification code 
  2. User enters verification code
  3. Done 
*/
Logger _log = Logger('SignInComponent');

class LoginInfo {
  String email = '';
  String? countryCode;
  String? phoneNumber;
  String verificationCode = '';

  String get validPhoneNumber => '$countryCode$phoneNumber';
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
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo_inverted_512.png",
                          width: 120,
                          height: 120,
                        ),
                        Text('RESONATES'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        child: Text('LOGIN'),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
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
          SignInValidateFlowComponent(
            pageController: _pageController,
            loginInfo: widget.loginInfo,
            command: user.loginCommand(),
          ),
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
    return SignInRequestComponent(command: command, loginInfo: loginInfo);
  }

  Widget _done(BuildContext context, bool result) {
    pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    command.clear();
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
  String _phoneNumber = '';
  String _countryCode = '+1';

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.loginInfo.countryCode = _countryCode;
      widget.loginInfo.phoneNumber = _phoneNumber;
      widget._command.execute(widget.loginInfo.validPhoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    _log.info('phoneNumber: ${widget.loginInfo.validPhoneNumber}');
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 56,
                  child: DropdownButtonFormField<String>(
                    initialValue: widget.loginInfo.countryCode ?? '+1',
                    items: [
                      DropdownMenuItem<String>(
                        value: "+1",
                        child: Text("+1", textAlign: TextAlign.center),
                      ),
                      DropdownMenuItem<String>(
                        value: "+44",
                        child: Text("+44", textAlign: TextAlign.center),
                      ),
                    ],
                    onSaved: (value) {
                      if (value != null) {
                        setState(() {
                          _countryCode = value;
                        });
                      }
                    },
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _countryCode = value;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 16,
                ), // Add some spacing between the dropdown and text field
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    initialValue: widget.loginInfo.phoneNumber,
                    decoration: InputDecoration(labelText: 'Phone #'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (!RegExp(r'^[\d\-]+$').hasMatch(value)) {
                        return 'Please enter a valid phone';
                      }
                      if (value.replaceAll(RegExp(r'[^\d]+'), '').length !=
                          10) {
                        return 'Wrong number of digits';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) {
                        setState(() => _phoneNumber = value);
                      }
                    },
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _phoneNumber = value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // FilledButton(onPressed: onPressed, child: child)
          FilledButton(onPressed: _submit, child: Text('Next')),
        ],
      ),
    );
  }
}

class SignInValidateFlowComponent extends StatelessWidget {
  const SignInValidateFlowComponent({
    super.key,
    required this.pageController,
    required this.loginInfo,
    required this.command,
  });

  final ApiResultNotifier2<bool, String, String> command;
  final PageController pageController;
  final LoginInfo loginInfo;

  Widget init(BuildContext context, {Exception? error}) {
    _log.info('error ::$error');
    return SignInValidateComponent(
      loginInfo: loginInfo,
      pageController: pageController,
      // execute: command.execute,
      command: command,
    );
  }

  Widget loading(BuildContext context) {
    return LoadingSpinnerComponent();
  }

  Widget done(BuildContext context, bool result) {
    command.clear();
    if (result) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigation to the loading screen to init the app
        Navigate(context).toHome();
      });
    }
    return init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ApiResultNotifierComponent(
      command: command,
      init: init,
      loading: (_) => LoadingSpinnerComponent(),
      done: done,
    );
  }
}

class SignInValidateComponent extends StatelessWidget {
  const SignInValidateComponent({
    super.key,
    required this.loginInfo,
    required this.pageController,
    // required this.execute,
    required this.command,
    // required this.authUser,
  });

  // final AuthUser authUser;
  final PageController pageController;
  final ApiResultNotifier2<bool, String, String> command;
  final LoginInfo loginInfo;
  // final Future<void> Function(String phoneNumber, String password) execute;

  @override
  Widget build(BuildContext context) {
    if (loginInfo.phoneNumber == null) {
      return TextButton(
        onPressed: () {
          pageController.previousPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: Text('Try Again'),
      );
    }
    var phoneNumber = loginInfo.phoneNumber ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Text(phoneNumber),
        VerificationCodeField(
          autofocus: true,
          enabled: true,
          length: 6,
          onFilled: (value) {
            _log.info('$value::${loginInfo.validPhoneNumber}');
            command.execute(loginInfo.validPhoneNumber, value);
          },
          spaceBetween: 16,
          matchingPattern: RegExp(r'^\d+$'),
        ),
        TextButton(
          onPressed: () {
            // TODO(duncan): How do i enable resend?
            // Definitely a hack as is
            pageController.previousPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Text('Resend'),
        ),
      ],
    );
  }
}
