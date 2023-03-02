import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  final snap;
  ProfilePage({required this.snap});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text('ProfilePage')),

    body: Column(
      children: [
        Image.network(snap)
      ],
    )
    );
  }
}