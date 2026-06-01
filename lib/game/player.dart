import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'sword.dart';

class Player extends RectangleComponent {
  final double speed = 300;
  Vector2 velocity = Vector2.zero();
  late Sword sword;
  double attackCooldown = 0;
  static const double attackDelay = 0.3;

  Player({required Vector2 position}) : super(
    size: Vector2(40, 40),
    position: position,
    paint: Paint()..color = Colors.blue,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Tambahkan sword
    sword = Sword(player: this);
    parent?.add(sword);
  }

  void move(Vector2 delta) {
    position += delta * speed / 100;
    position.x = position.x.clamp(40, gameRef.size.x - 40);
    position.y = position.y.clamp(40, gameRef.size.y - 40);
  }

  void attack() {
    if (attackCooldown <= 0) {
      sword.slash();
      attackCooldown = attackDelay;
    }
  }

  Rect get hitbox => Rect.fromCenter(
    center: Offset(position.x, position.y),
    width: size.x,
    height: size.y,
  );

  Rect getSwordHitbox() => sword.getHitbox();

  @override
  void update(double dt) {
    super.update(dt);
    if (attackCooldown > 0) {
      attackCooldown -= dt;
      if (attackCooldown <= 0) sword.reset();
    }
  }
}