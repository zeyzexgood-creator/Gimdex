import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends RectangleComponent {
  final double speed = 400;
  double attackTimer = 0;
  bool isAttacking = false;
  
  Player() : super(
    size: Vector2(45, 45),
    paint: Paint()..color = Colors.blue,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  void move(Vector2 delta) {
    position += delta * speed / 60;
    
    // Batasi di layar
    final game = gameRef;
    position.x = position.x.clamp(size.x/2, game.size.x - size.x/2);
    position.y = position.y.clamp(size.y/2, game.size.y - size.y/2);
  }

  void attack() {
    if (attackTimer <= 0) {
      isAttacking = true;
      attackTimer = 0.3;
      paint.color = Colors.lightBlue;
    }
  }

  Rect get hitbox => Rect.fromCenter(
    center: Offset(position.x, position.y),
    width: size.x + 25, // Sword range
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