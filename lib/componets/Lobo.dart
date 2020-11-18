import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_base/componets/Ovelha.dart';

import '../main.dart';

const ComponentSize = 60.0;
const SPEED = 150.0;

class Lobo extends SpriteComponent {
  Size dimensions;
  Random random = new Random();
  bool remove = false;
  Ovelha player;

  Lobo(this.dimensions, this.player)
      : super.square(ComponentSize, 'lobo.png');

  @override
  void update(double t) {
    super.update(t);
    this.y += t * SPEED;
    if (!player.gameover) {
      bool remove = this.toRect().contains(player.toRect().bottomCenter) ||
          this.toRect().contains(player.toRect().bottomLeft) ||
          this.toRect().contains(player.toRect().bottomRight);
      if (remove) {
        player.gameover = true;
        Navigator.pushReplacement(
            buildContext,
            MaterialPageRoute(
              builder: (context) => GameOverScreen(player),
            ));
      }
    }
  }

  @override
  bool destroy() {
    return remove;
  }

  @override
  void resize(Size size) {
    var positionX = random.nextDouble();
    print(positionX);

    this.x = positionX * 300;
    this.y = 0;
  }
}
