import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'enemy.dart';

class HackSlashGame extends FlameGame with DragCallbacks, TapCallbacks {
  late Player player;
  final List<Enemy> enemies = [];
  int score = 0;
  late TextComponent scoreText;
  Vector2? lastDragPosition;

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
      enemy.position = randomSpawnPosition();
      enemies.add(enemy);
      add(enemy);
    }
  }

  Vector2 randomSpawnPosition() {
    final rand = DateTime.now().millisecondsSinceEpoch % 4;
    switch (rand) {
      case 0: return Vector2(-40, size.y / 2);
      case 1: return Vector2(size.x + 40, size.y / 2);
      case 2: return Vector2(size.x / 2, -40);
      default: return Vector2(size.x / 2, size.y + 40);
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
  void onDragUpdate(DragUpdateEvent event) {
    player.move(event.delta.game);
    super.onDragUpdate(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    attack();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Update posisi semua enemy
    for (var enemy in enemies) {
      final direction = (player.position - enemy.position).normalized();
      enemy.position += direction * enemy.speed * dt;
    }
  }
}