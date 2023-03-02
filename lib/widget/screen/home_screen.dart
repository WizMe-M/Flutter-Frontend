import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/page/edit_profile_page.dart';
import 'package:flutter_frontend/widget/page/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.authorized}) : super(key: key);
  final User authorized;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      ProfilePage(authorized: widget.authorized),
      EditableProfilePage(authorized: widget.authorized),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              tooltip: 'Open profile page'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Edit Profile',
              tooltip: 'Edit profile page'),
        ],
        currentIndex: currentPage,
        onTap: (value) => setState(() {
          currentPage = value;
        }),
      ),
      body: pages[currentPage],
    );
  }
}
