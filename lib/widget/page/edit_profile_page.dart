import 'package:flutter/material.dart';
import 'package:flutter_frontend/dio_client.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

class EditableProfilePage extends StatefulWidget {
  const EditableProfilePage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<EditableProfilePage> createState() => _EditableProfilePageState();
}

class _EditableProfilePageState extends State<EditableProfilePage> {
  final DioClient _client = DioClient();

  late TextEditingController _emailController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _usernameController = TextEditingController(text: '');

    fetchUser();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void fetchUser() async {
    var response = await _client.getProfile(token: widget.token);
    var user = User.fromJson(response!.data);
    _emailController.text = user.email!;
    _usernameController.text = user.userName!;
  }

  void updateProfile() async {
    var response = await _client.updateProfile(
        token: widget.token,
        username: _usernameController.text,
        email: _emailController.text);

    if (response == null || response.error!.isNotEmpty) {
      var alert = AlertDialog(
        title: const Text('Update profile error'),
        content: Text(response?.error ?? 'Unknown error'),
      );

      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => alert,
        );
      }
    }

    fetchUser();
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
