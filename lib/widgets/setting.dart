import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
          backgroundColor: Colors.blue,
        ),
        body: const Text("Coming Soon!!"),
      ),
    );
  }
}
