import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:mobial/page/profile_page.dart';
import 'package:mobial/login9/ui/login_page.dart';
import 'package:mobial/privacy_policy.dart';
import 'package:mobial/settings.dart';
import 'package:localstorage/localstorage.dart';

Widget drawer(BuildContext context) {
  final LocalStorage storage = new LocalStorage('mobial');
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('moBIAL'),
        ),
        ListTile(
          title: const Text('Account'),
          leading: IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a Account button')));
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProfilePage();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Settings();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Privacy Policy'),
          leading: IconButton(
            icon: const Icon(Icons.privacy_tip),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PrivacyPolicy();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Log Out'),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a Logout button')));
            },
          ),
          onTap: () {
            storage.deleteItem('user');
            storage.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Login9();
                },
              ),
            );
          },
        ),
      ],
    ),
  );
}
