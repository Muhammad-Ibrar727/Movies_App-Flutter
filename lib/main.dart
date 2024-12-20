import 'package:flutter/material.dart';
import 'package:movies/pages/LoginAndSignUp/Login.dart';
import 'package:movies/pages/LoginAndSignUp/SignUp.dart';
import 'package:movies/pages/TrendingMovies/TrendingMovies.dart';
import 'package:movies/pages/homePage.dart';
import 'package:movies/pages/popularMovies/popularMovies.dart';
import 'package:movies/pages/settings/widgets/contactUs.dart';

import 'pages/mainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff221F2A),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.black),
      ),
      routes: {
        'mainPage': (context) => const MainPage(),
        'homePage': (context) => const Homepage(),
        'signupAndLogin': (context) => const Login(),
        'trendingMovies': (context) => TrendingMovies(),
        'popularMovies': (context) => const PopularMovies(),
        'signUp': (context) => const Signup(),
        'logIn': (context) => Login(),
        'contactUs':(context) => Contactus(),
      },
      home: const MainPage(),
    );
  }
}
