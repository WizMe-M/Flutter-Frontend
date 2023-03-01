import 'package:flutter/material.dart';
import 'package:flutter_frontend/dio_client.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final DioClient _client = DioClient();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordHidden = true;

  void onSignUpPressed(String email, String username, String password) async {
    var response = await _client.register(
        email: email, username: username, password: password);

    AlertDialog alert;
    if (response == null) {
      alert = const AlertDialog(
        title: Text('Registration attempt'),
        content: Text('Registration failed. Try to restart API'),
      );
    } else {
      alert = AlertDialog(
        title: const Text('Registration attempt'),
        content: Text(response.message!),
        actions: [TextButton(onPressed: () {}, child: const Text('Sign In'))],
      );
    }

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
            height: 350,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DynamicInputWidget(
                  controller: _emailController,
                  prefIcon: Icons.email,
                  labelText: 'Email',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                  obscureText: isPasswordHidden,
                  isPasswordField: true,
                  toggleObscureCallback: togglePasswordObscure,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      onSignUpPressed(_emailController.text,
                          _usernameController.text, _passwordController.text);
                    },
                    child: const Text('Sign Up')),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(onPressed: () {}, child: const Text('Authorize'))
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
