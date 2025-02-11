import 'dart:async';

import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, 'mainPage');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/appLogo.jpg'),
          ),
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   'MovieGo',
          //   style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //       letterSpacing: 3,
          //       color: Colors.amber),
          // ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.pink,
                    Colors.white,
                    Colors.blue,
                    // Colors.red
                  ]).createShader(bounds);
            },
            child: const Text(
              'MoviGo',
              style: TextStyle(
                  fontFamily: 'BankGothic',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 3,
                  color: Colors.amber),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Enjoy the movies with MovieGo!!!',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15,
              color: Colors.white60,
              letterSpacing: 1.7,
              wordSpacing: 1.4,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const CircularProgressIndicator(
            // backgroundColor: Colors.blue,
            strokeWidth: 3,
          )
        ],
      )),
    );
  }
}
