import 'package:flutter/material.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordHidden = true;

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
                  labelText: 'Enter Username',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                DynamicInputWidget(
                  controller: _passwordController,
                  prefIcon: Icons.password,
                  labelText: 'Enter Password',
                  textInputAction: TextInputAction.done,
                  obscureText: isPasswordHidden,
                  isPasswordField: true,
                  toggleObscureCallback: togglePasswordObscure,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Sign In')),
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
