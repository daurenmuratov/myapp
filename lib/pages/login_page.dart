import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: _buildUI(context),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      'Recip Book',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'kminchelle',
              onSaved: (value) => setState(() {
                username = value;
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your username';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              initialValue: '0lelplR',
              obscureText: false,
              onSaved: (value) => setState(() {
                password = value;
              }),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Enter a valid password';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: ElevatedButton(
        onPressed: () async {
          if (loginFormKey.currentState?.validate() ?? false) {
            loginFormKey.currentState?.save();
            bool result = await AuthService().login(username!, password!);
            if (result) {
              await Navigator.pushNamed(context, '/home');
            } else {
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: 'Login Failed',
                configuration: const IconConfiguration(icon: Icons.error),
              );
            }
          }
        },
        child: const Text('Login'),
      ),
    );
  }
}
