import 'package:flutter/material.dart';
import 'package:flutter_frontend/dio_client.dart';
import 'package:flutter_frontend/model/model_response.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/routing/enum_app_page.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final DioClient _client = DioClient();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordHidden = true;

  void showAuthAttemptDialog(ModelResponse? response) {
    AlertDialog alert;

    if (response == null) {
      alert = const AlertDialog(
        title: Text('Auth attempt'),
        content: Text('Authorization failed. Try to restart API'),
      );
    } else {
      User? user;
      var authorized = response.error == null || response.error!.isEmpty;
      if (authorized) {
        user = User.fromJson(response.data);
      }

      alert = AlertDialog(
          title: const Text('Auth attempt'),
          content: Text(response.message!),
          actions: [
            TextButton(
                onPressed: () {
                  if (authorized) {
                    context.pop();
                    // context.go(AppPage.signUp.path);
                  } else {
                    context.pop();
                  }
                },
                child: const Text('OK'))
          ]);
    }
    showDialog(context: context, builder: (context) => alert);
  }

  void onSignInPressed() async {
    var response = await _client.authenticate(
        username: _usernameController.text, password: _passwordController.text);
    showAuthAttemptDialog(response);
  }

  void togglePasswordObscure() {
    setState(() => isPasswordHidden = !isPasswordHidden);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            height: 300,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DynamicInputWidget(
                  controller: _usernameController,
                  prefIcon: Icons.person,
                  labelText: 'Username',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                DynamicInputWidget(
                  controller: _passwordController,
                  prefIcon: Icons.password,
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  obscureText: isPasswordHidden,
                  isPasswordField: true,
                  toggleObscureCallback: togglePasswordObscure,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: onSignInPressed, child: const Text('Sign In')),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account yet?"),
                    TextButton(
                        onPressed: () {
                          context.go(AppPage.signUp.path);
                        },
                        child: const Text('Register'))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
