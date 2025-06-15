import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:race/components/car.dart';
import 'package:race/screens/countdown.dart';
import 'package:race/components/finish.dart';
import 'package:race/models/player_data.dart';
import 'package:race/screens/paused.dart';
import 'package:race/components/pylon.dart';
import 'package:race/components/star.dart';
import 'package:race/screens/hud.dart';

class RaceScreen extends FlameGame with HasCollisionDetection {
  final String color;
  late Player player;
  late SpriteComponent start;
  late SpriteComponent background;
  late PlayerData playerData;
  int countdown = 3;
  double timer = 1;
  bool isRunning = false;
  int stars = 0;
  final Random _random = Random();
  double randomThing = 0;
  HudState? hudState;
  final BuildContext context;
  double duration = 0;
  bool isFinished = false;
  CountdownState? counter;

  RaceScreen({required this.color, required this.context});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    player = Player(color: color);

    start = SpriteComponent()
      ..sprite = await loadSprite('start_track.png')
      ..size = Vector2(size.x, size.y)
      ..position = Vector2(0, 0);

    background = SpriteComponent()
      ..sprite = await loadSprite('default_track.png')
      ..size = Vector2(size.x, size.y + size.y)
      ..position = Vector2(0, size.y);

    add(background);
    add(start);
    add(player);
    overlays.add(Countdown.id);
  }

  void pauseGame() {
    if (isRunning) {
      pauseEngine();
      isRunning = false;
    } else {
      resumeEngine();
      isRunning = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isRunning) {
      timer -= dt;

      if (timer <= 0) {
        countdown -= 1;
        counter?.getCount(countdown);
        timer = 1;

        if (countdown > 0) {
        } else {
          overlays.remove(Countdown.id);
          isRunning = true;
          overlays.add(PausedScreen.id);
        }
      }
      return;
    }
    if (isRunning) {
      duration += dt;

      if (duration >= 20 && !isFinished) {
        isFinished = true;

        add(Finish(Vector2(0, size.y), Vector2(size.x, size.y)));
      }
    }

    start.position.y += 400 * dt;
    background.position.y += 400 * dt;
    if (start.position.y >= size.y) {
      start.removeFromParent();
    }
    if (background.position.y >= 0) {
      background.position.y = -size.y;
    }

    randomThing += dt;
    if (randomThing > 2 && !isFinished) {
      randomThing = 0;
      bool randomPosition = _random.nextBool();
      bool randomObject = _random.nextBool();

      if (randomObject) {
        add(Star(Vector2(randomPosition ? 100 : 225, -50)));
      } else {
        add(Pylon(Vector2(randomPosition ? 100 : 225, -50)));
      }
    }
  }

  void getLeft() {
    player.moveLeft(-1);
  }

  void getRight() {
    player.moveLeft(1);
  }
}
