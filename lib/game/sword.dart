import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'player.dart';

class Sword extends RectangleComponent {
  final Player player;
  double angle = 0;
  double slashProgress = 0;
  bool isSlashing = false;
  final double swordLength = 50;

  Sword({required this.player}) : super(
    size: Vector2(30, 10),
    paint: Paint()..color = Colors.grey.shade300,
    anchor: Anchor.centerLeft,
  );

  void slash() {
    isSlashing = true;
    slashProgress = 0;
  }

  void reset() {
    isSlashing = false;
    angle = 0;
  }

  Rect getHitbox() {
    if (!isSlashing) return Rect.zero;
    
    final center = Offset(player.position.x, player.position.y);
    final rad = angle;
    final tipX = player.position.x + swordLength * cos(rad);
    final tipY = player.position.y + swordLength * sin(rad);
    
    return Rect.fromPoints(
      center,
      Offset(tipX, tipY),
    ).inflate(15);
  }

  @override
  void update(double dt) {
    if (isSlashing) {
      slashProgress += dt * 10; // kecepatan slash
      if (slashProgress >= 1) {
        reset();
      } else {
        // Animasi 0 -> PI/2 -> 0
        final t = slashProgress * 2;
        if (t <= 1) {
          angle = t * 1.57;
        } else {
          angle = (2 - t) * 1.57;
        }
      }
    }
    
    position = player.position;
    rotation = angle;
  }
}