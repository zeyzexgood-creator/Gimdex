import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'enemy.dart';

class HackSlashGame extends FlameGame {
  late Player player;
  final List<Enemy> enemies = [];
  int score = 0;
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    // Player
    player = Player();
    player.position = size / 2;
    add(player);

    // Score text
    scoreText = TextComponent(
      text: 'Score: 0',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      position: Vector2(20, 40),
    );
    add(scoreText);

    // Spawn enemies setiap 1.2 detik
    add(TimerComponent(
      period: 1.2,
      repeat: true,
      onTick: () => spawnEnemy(),
    ));
  }

  void spawnEnemy() {
    if (enemies.length < 10) {
      final enemy = Enemy();
      final rand = DateTime.now().millisecondsSinceEpoch % 4;
      switch (rand) {
        case 0:
          enemy.position = Vector2(-40, size.y / 2);
          break;
        case 1:
          enemy.position = Vector2(size.x + 40, size.y / 2);
          break;
        case 2:
          enemy.position = Vector2(size.x / 2, -40);
          break;
        default:
          enemy.position = Vector2(size.x / 2, size.y + 40);
      }
      enemies.add(enemy);
      add(enemy);
    }
  }

  void attack() {
    player.attack();
    final playerRect = player.hitbox;
    
    for (final enemy in enemies.toList()) {
      if (playerRect.overlaps(enemy.hitbox)) {
        enemy.takeDamage();
        if (enemy.health <= 0) {
          enemies.remove(enemy);
          enemy.removeFromParent();
          score++;
          scoreText.text = 'Score: $score';
        }
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Enemy bergerak ke arah player
    for (var enemy in enemies) {
      final direction = (player.position - enemy.position).normalized();
      enemy.position += direction * enemy.speed * dt;
    }
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    // Player mengikuti mouse
    player.position = info.eventPosition.game;
    player.position.x = player.position.x.clamp(
      player.size.x/2, 
      size.x - player.size.x/2
    );
    player.position.y = player.position.y.clamp(
      player.size.y/2, 
      size.y - player.size.y/2
    );
    super.onMouseMove(info);
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    attack();
    super.onTapDown(pointerId, info);
  }
}