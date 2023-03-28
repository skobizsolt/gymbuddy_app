import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;

  @override
  void initState() {
    _isObscure1 = false;
    _isObscure2 = false;
    _isObscure3 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
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
                    // TextField(
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     label: Text('Full Name'),
                    //     prefixIcon: Icon(Icons.person_outline_rounded),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // TextField(
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     label: Text('Username'),
                    //     prefixIcon: Icon(Icons.verified_user_outlined),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // TextField(
                    //   enabled: false,
                    //   decoration: InputDecoration(
                    //     label: Text('E-mail'),
                    //     prefixIcon: Icon(Icons.email_outlined),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: _isObscure1,
                      decoration: InputDecoration(
                        label: Text('Current password'),
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure1
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure1 = !_isObscure1;
                              });
                            }),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: _isObscure2,
                      decoration: InputDecoration(
                        label: Text('New password'),
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure2
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            }),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      obscureText: _isObscure3,
                      decoration: InputDecoration(
                        label: Text('Re-enter new password'),
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure3
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            }),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        //TODO: implement changePwd
                        onPressed: () {},
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
