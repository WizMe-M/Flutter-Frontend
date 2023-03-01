import 'package:flutter/material.dart';
import 'package:flutter_frontend/dio_client.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

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

  void onSignInPressed(String username, String password) async {
    var response =
        await _client.authenticate(username: username, password: password);
    if (response == null) {
      var alert = const AlertDialog(
        title: Text('Auth:'),
        content: Text('Authorization failed. Try to restart API'),
      );
      showDialog(
        context: context,
        builder: (context) => alert,
      );
      return;
    }

    var alert = AlertDialog(
        title: const Text('Auth Attempt: '),
        content: Text(response.message!),
        actions: [
          TextButton(
              onPressed: () {
                if (response.error!.isNotEmpty) {
                  Navigator.of(context, rootNavigator: true).pop();
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const Text('Authorized');
                      },
                    ),
                  );
                }
              },
              child: const Text('OK'))
        ]);
    showDialog(context: context, builder: (context) => alert);
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    onPressed: () {
                      onSignInPressed(
                          _usernameController.text, _passwordController.text);
                    },
                    child: const Text('Sign In')),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account yet?"),
                    TextButton(onPressed: () {}, child: const Text('Register'))
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
