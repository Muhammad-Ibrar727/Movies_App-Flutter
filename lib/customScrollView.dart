import 'package:flutter/material.dart';

class Customscrollview extends StatelessWidget {
  const Customscrollview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 400,
            leading: Stack(children: [
              Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'images/img4.jpg',
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ]),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/img4.jpg'),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              tileColor: const Color.fromARGB(255, 126, 126, 126),
              title: Text("$index"),
            );
          }, childCount: 100))
        ],
      ),
    );
  }
}
