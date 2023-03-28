import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import 'reset_password_screen.dart';
import 'tab_screen.dart';

enum AuthMode { Signup, Login }

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              padding: const EdgeInsets.only(top: 150, left: 100, right: 100),
              child: Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              height: deviceSize.height,
              child: Column(
                children: <Widget>[
                  Container(
                    width: deviceSize.width,
                    height: 200,
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AuthCard(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'username': '',
    'email': '',
    'password': '',
    'matchingPassword': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _matchingPasswordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An error occured',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        alignment: Alignment.center,
        title: Text(
          'Successful registration',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        print(_authData);
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['username']!, _authData['password']!);
        Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
      } else {
        print(_authData);
        await Provider.of<Auth>(context, listen: false)
            .signup(
          _authData['username']!,
          _authData['email']!,
          _authData['password']!,
          _authData['matchingPassword']!,
        )
            .then((value) {
          _authMode = AuthMode.Login;
        });
      }
    } catch (error) {
      const errorMessage = 'Could not authenticate you.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _authMode == AuthMode.Login ? 450 : 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.elasticInOut,
      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: ValueKey('username'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle_rounded),
                  hintText: 'Username',
                  filled: true,
                  fillColor: Color(0xffdadada),
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.name,
                onSaved: (value) {
                  _authData['username'] = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (_authMode == AuthMode.Signup)
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: TextFormField(
                    key: ValueKey('email'),
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'E-mail',
                      filled: true,
                      fillColor: Color(0xffdadada),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        print(value);
                        return 'Invalid e-mail!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: ValueKey('password'),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color(0xffdadada),
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Password must be minimum 8 character long!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (_authMode == AuthMode.Signup)
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: TextFormField(
                    key: ValueKey('matchingPassword'),
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Confirm password',
                      filled: true,
                      fillColor: Color(0xffdadada),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    controller: _matchingPasswordController,
                    onSaved: (value) {
                      _authData['matchingPassword'] = value!;
                    },
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPasswordScreen())),
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange),
                onPressed: _submit,
                child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: _switchAuthMode,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange,
                ),
                child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
