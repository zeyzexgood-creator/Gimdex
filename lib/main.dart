import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/hack_slash_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hack & Slash',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(game: HackSlashGame()),
      ),
    );
  }
}