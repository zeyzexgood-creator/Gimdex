import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Enemy extends RectangleComponent {
  double health = 2;
  final double speed = 70;
  
  Enemy() : super(
    size: Vector2(35, 35),
    paint: Paint()..color = Colors.red,
    anchor: Anchor.center,
  );

  void takeDamage() {
    health--;
    paint.color = Colors.orange;
    Future.delayed(const Duration(milliseconds: 100), () {
      if (health > 0) paint.color = Colors.red;
      else paint.color = Colors.grey;
    });
  }

  Rect get hitbox => Rect.fromCenter(
    center: Offset(position.x, position.y),
    width: size.x,
    height: size.y,
  );
}