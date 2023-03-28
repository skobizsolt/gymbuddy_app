import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import 'authentication_screen.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _logout() async {
    Auth().logout();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AuthenticationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Text('név', style: Theme.of(context).textTheme.headline4),
              // Text('email', style: Theme.of(context).textTheme.bodyText2),
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen())),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      side: BorderSide.none,
                      shape: StadiumBorder()),
                  child: Text(
                    'Edit profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),

              //MENU
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.cyan.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.password_rounded,
                    size: 16.0,
                    color: Color.fromRGBO(255, 0, 255, 1.0),
                  ),
                ),
                title: Text(
                  'Change password',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen())),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.cyan.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.logout,
                    size: 16.0,
                    color: Color.fromRGBO(255, 0, 255, 1.0),
                  ),
                ),
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: _logout,
              ),
            ],
          ),
        ),
        // child: ElevatedButton(
        //   onPressed: _logout,
        //   child: Text("Logout"),
      ),
    );
  }
}
