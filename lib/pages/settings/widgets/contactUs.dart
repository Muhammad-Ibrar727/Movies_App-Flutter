import 'package:flutter/material.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact'),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.grey,
              height: 300,
              width: 500,
            )
          ],
        ));
  }
}
