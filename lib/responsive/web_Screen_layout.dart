import 'package:flutter/material.dart';

class Web_Screen_layout extends StatefulWidget {
  const Web_Screen_layout({Key? key}) : super(key: key);

  @override
  State<Web_Screen_layout> createState() => _Web_Screen_layoutState();
}

class _Web_Screen_layoutState extends State<Web_Screen_layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instagram"),
      ),
      body: const Center(
        child: Text("This is web version"),
      ),
    );
  }
}
