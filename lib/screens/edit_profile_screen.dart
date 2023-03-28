import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, String> _authData = {
    'userId': '',
    'fullName': '',
  };

  void _updateUser() async {
    try {
      await Provider.of<Profile>(context, listen: false)
          .updateUser(_authData['fullName']!);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Form(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        label: Text('Full Name'),
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        label: Text('Username'),
                        prefixIcon: Icon(Icons.verified_user_outlined),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        label: Text('E-mail'),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _updateUser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            side: BorderSide.none,
                            shape: StadiumBorder()),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Text.rich(
                    //       TextSpan(
                    //         text: 'Registered at',
                    //         style: TextStyle(fontSize: 12),
                    //         children: [
                    //           TextSpan(
                    //               text: ' asd',
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 12))
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
