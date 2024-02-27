import 'package:flutter/material.dart';

class TweetsPage extends StatefulWidget {
  const TweetsPage({super.key});

  @override
  State<TweetsPage> createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.yellow,
    );
  }
}
