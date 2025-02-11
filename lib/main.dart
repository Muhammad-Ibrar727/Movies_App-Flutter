import 'package:flutter/material.dart';
import 'package:movies/customScrollView.dart';
import 'package:movies/pages/LoginAndSignUp/Login.dart';
import 'package:movies/pages/LoginAndSignUp/SignUp.dart';
import 'package:movies/pages/SplashScreen/splashScreen.dart';
import 'package:movies/pages/TopRatedMovies/allTopRated.dart';
import 'package:movies/pages/UpcommingMovies/AllUpcomming.dart';
import 'package:movies/pages/homePage.dart';
import 'package:movies/pages/popularMovies/AllpopularMovies.dart';
import 'package:movies/pages/settings/widgets/contactUs.dart';
import 'package:movies/pages/TopRatedMovies/topRated.dart';
import 'package:movies/pages/TrendingMovies/trendingmoviespage.dart';

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
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'BankGothic', fontWeight: FontWeight.w900)),
        scaffoldBackgroundColor: const Color(0xff221F2A),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.black),
      ),
      initialRoute: 'splashScreen',
      routes: {
        'mainPage': (context) => const MainPage(),
        'homePage': (context) => const Homepage(),
        'signupAndLogin': (context) => const Login(),
        'topRated': (context) => const TopRated(),
        'trendingMovies': (context) => const TrendingMoviesScreen(),
        'signUp': (context) => const Signup(),
        'logIn': (context) => const Login(),
        'contactUs': (context) => const Contactus(),
        // 'trailer': (context) => const MovieTrailerScreen(),
        'customScroll': (context) => const Customscrollview(),
        'splashScreen': (context) => const Splashscreen(),
        'allPopularMovies': (context) => const AllPopularMovies(),
        'allTopRatedMovies': (context) => const AllTopRatedMovies(),
        'allUpcommingMovies': (context) => const AllUpCommingMovies(),
        // 'searchScreen': (context) => const Searchscreen(),
      },
    );
  }
}
