import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Enemy extends RectangleComponent {
  double health = 2;
  final double speed = 80;
  late double originalHealth;

  Enemy({required Vector2 position}) : super(
    size: Vector2(35, 35),
    position: position,
    paint: Paint()..color = Colors.red,
    anchor: Anchor.center,
  );

  void takeDamage() {
    health--;
    // Flash merah saat kena damage
    paint.color = Colors.orange;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (health > 0) paint.color = Colors.red;
    });
  }

  Rect get hitboxRect => Rect.fromCenter(
    center: Offset(position.x, position.y),
    width: size.x,
    height: size.y,
  );

  @override
  void update(double dt) {
    // Bergerak ke arah player
    final player = (parent as dynamic).gameRef.player;
    final direction = (player.position - position).normalized();
    position += direction * speed * dt;
  }
}