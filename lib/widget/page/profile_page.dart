import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.authorized}) : super(key: key);

  final User authorized;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.authorized.email);
    _usernameController =
        TextEditingController(text: widget.authorized.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: SizedBox(
            height: 400,
            width: 300,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Your profile data:', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 40),
              DynamicInputWidget(
                  controller: _emailController,
                  readonly: true,
                  labelText: 'Email',
                  prefixIcon: Icons.email),
              const SizedBox(height: 20),
              DynamicInputWidget(
                  controller: _usernameController,
                  readonly: true,
                  labelText: 'Username',
                  prefixIcon: Icons.account_box_sharp),
            ]),
          )),
        ),
      ),
    );
  }
}
