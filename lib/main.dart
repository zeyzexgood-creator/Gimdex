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
        body: Stack(
          children: [
            GameWidget(game: HackSlashGame()),
            Positioned(
              top: 20,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '🎮 Gerakkan mouse | Klik untuk serang',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}