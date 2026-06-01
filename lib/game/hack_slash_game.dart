import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'enemy.dart';

class HackSlashGame extends FlameGame 
    with PanDetector, MultiTouchDragDetector {
  late Player player;
  final List<Enemy> enemies = [];
  int score = 0;
  late TextComponent scoreText;
  late JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    // Camera
    camera.viewfinder.anchor = Anchor.center;
    
    // Player
    player = Player(position: size / 2);
    add(player);

    // Score text
    scoreText = TextComponent(
      text: 'Slain: 0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      position: Vector2(20, 50),
      priority: 100,
    );
    add(scoreText);

    // Spawn enemies periodically
    add(TimerComponent(
      period: 1.0,
      repeat: true,
      onTick: () => spawnEnemy(),
    ));
  }

  void spawnEnemy() {
    if (enemies.length < 15) {
      final enemy = Enemy(position: randomSpawnPosition());
      enemies.add(enemy);
      add(enemy);
    }
  }

  Vector2 randomSpawnPosition() {
    final side = DateTime.now().millisecond % 4;
    switch (side) {
      case 0: return Vector2(-50, size.y / 2);
      case 1: return Vector2(size.x + 50, size.y / 2);
      case 2: return Vector2(size.x / 2, -50);
      default: return Vector2(size.x / 2, size.y + 50);
    }
  }

  void attack() {
    player.attack();
    final swordHitbox = player.getSwordHitbox();
    
    for (final enemy in enemies.toList()) {
      if (enemy.hitboxRect.overlaps(swordHitbox)) {
        enemy.takeDamage();
        if (enemy.health <= 0) {
          enemies.remove(enemy);
          enemy.removeFromParent();
          score++;
          scoreText.text = 'Slain: $score';
        }
      }
    }
  }

  void movePlayer(Vector2 delta) {
    player.move(delta);
    // Kamera mengikuti player
    camera.viewfinder.position = player.position;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    movePlayer(info.delta.game);
    super.onPanUpdate(info);
  }

  @override
  void onTapUp(TapUpInfo info) {
    attack();
    super.onTapUp(info);
  }
}