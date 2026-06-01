import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent {
  double attackTimer = 0;
  bool isAttacking = false;
  
  Player() : super(
    size: Vector2(45, 45),
    paint: Paint()..color = Colors.blue,
    anchor: Anchor.center,
  );

  void attack() {
    if (attackTimer <= 0) {
      isAttacking = true;
      attackTimer = 0.3;
      paint.color = Colors.lightBlue;
    }
  }

  Rect get hitbox => Rect.fromCenter(
    center: Offset(position.x, position.y),
    width: size.x + 25, // Radius serangan
    height: size.y + 25,
  );

  @override
  void update(double dt) {
    super.update(dt);
    
    if (attackTimer > 0) {
      attackTimer -= dt;
      if (attackTimer <= 0) {
        isAttacking = false;
        paint.color = Colors.blue;
      }
    }
  }
}