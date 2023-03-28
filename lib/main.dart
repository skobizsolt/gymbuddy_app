import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/profile.dart';

import './screens/authentication_screen.dart';
import './screens/tab_screen.dart';

void main() {
  runApp(const GymBuddy());
}

class GymBuddy extends StatelessWidget {
  const GymBuddy({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Profile(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.cyan,
            accentColor: const Color.fromRGBO(255, 0, 255, 1.0),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        routes: {
          '/': (context) => AuthenticationScreen(),
          TabScreen.routeName: (context) => TabScreen(),
        },
      ),
    );
  }
}
