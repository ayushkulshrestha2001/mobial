import 'package:flutter/material.dart';
import 'package:mobial/widgets/check_list.dart';
import 'package:mobial/pages/page/profile_page.dart';
import 'package:mobial/login9/ui/login_page.dart';
import 'package:mobial/widgets/privacy_policy.dart';
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobial/widgets/settings.dart';

Widget drawer(BuildContext context) {
  final LocalStorage storage = new LocalStorage('mobial');
  return Drawer(
    backgroundColor: Color(0xff8CCEC8),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/img/headerbg.jpg'),
            ),
          ),
          child: Center(
            child: Text(
              "MoBIAL",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Account',
            style: GoogleFonts.signika(
              fontSize: 17.0,
            ),
          ),
          leading: Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
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
          title: Text(
            'Check List',
            style: GoogleFonts.signika(
              fontSize: 17.0,
            ),
          ),
          leading: Icon(
            Icons.list,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TodoLIst();
                },
              ),
            );
          },
        ),
        // ListTile(
        //   title: Text(
        //     'Settings',
        //     style: GoogleFonts.signika(
        //       fontSize: 17.0,
        //     ),
        //   ),
        //   leading: Icon(
        //     Icons.settings,
        //     color: Colors.black,
        //   ),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return Settings();
        //         },
        //       ),
        //     );
        //   },
        // ),
        ListTile(
          title: Text('Privacy Policy',
              style: GoogleFonts.signika(
                fontSize: 17.0,
              )),
          leading: Icon(
            Icons.privacy_tip,
            color: Colors.black,
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
          title: Text('Log Out',
              style: GoogleFonts.signika(
                fontSize: 17.0,
              )),
          leading: Icon(
            Icons.logout,
            color: Colors.black,
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
