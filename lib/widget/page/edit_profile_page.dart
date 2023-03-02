import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

class EditableProfilePage extends StatefulWidget {
  const EditableProfilePage({Key? key, required this.authorized})
      : super(key: key);

  final User authorized;

  @override
  State<EditableProfilePage> createState() => _EditableProfilePageState();
}

class _EditableProfilePageState extends State<EditableProfilePage> {
  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.authorized.email);
    _usernameController =
        TextEditingController(text: widget.authorized.userName);
  }

  void updateProfile() async {}

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
              const Text('Edit profile', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 40),
              DynamicInputWidget(
                  controller: _emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email),
              const SizedBox(height: 20),
              DynamicInputWidget(
                  controller: _usernameController,
                  labelText: 'Username',
                  prefixIcon: Icons.account_box_sharp),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: updateProfile, child: const Text('Save changes'))
            ]),
          )),
        ),
      ),
    );
  }
}
