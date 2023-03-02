import 'package:flutter/material.dart';
import 'package:flutter_frontend/dio_client.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/utils/dynamic_auth_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
