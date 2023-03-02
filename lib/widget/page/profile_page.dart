import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.authorized}) : super(key: key);

  final User authorized;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('User Email: ${widget.authorized.email}'),
      ),
    );
  }
}
