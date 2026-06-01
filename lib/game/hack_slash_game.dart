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
  Vector2 targetPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    // Player
    player = Player();
    player.position = size / 2;
    targetPosition = size / 2;
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

    // Spawn enemies
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
    
    // Gerakan player ke target position (smooth)
    final direction = (targetPosition - player.position);
    if (direction.length > 5) {
      player.position += direction.normalized() * 300 * dt;
    }
    
    // Batasi posisi player
    player.position.x = player.position.x.clamp(
      player.size.x/2, 
      size.x - player.size.x/2
    );
    player.position.y = player.position.y.clamp(
      player.size.y/2, 
      size.y - player.size.y/2
    );
    
    // Enemy bergerak ke player
    for (var enemy in enemies) {
      final directionEnemy = (player.position - enemy.position).normalized();
      enemy.position += directionEnemy * enemy.speed * dt;
    }
  }

  // Flame 1.15.0 menggunakan onTapDown dengan parameter berbeda
  @override
  void onTapDown(int pointerId, TapDownDetails details) {
    // Konversi ke Vector2
    final tapPosition = Vector2(details.localPosition.dx, details.localPosition.dy);
    targetPosition = tapPosition;
    attack();
    super.onTapDown(pointerId, details);
  }
}