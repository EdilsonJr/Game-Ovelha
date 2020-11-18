import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_base/componets/Ovelha.dart';

const ComponentSize = 60.0;
const SPEED = 150.0;

class Moeda extends SpriteComponent {
  Size dimensions;
  Random random = new Random();
  Ovelha player;
  bool destruir = false;

  Moeda(this.dimensions,this.player) : super.square(ComponentSize, 'moeda.png');

  @override
  void update(double t) {
    super.update(t);
    this.y += t * SPEED;
    if (!player.gameover) {
      bool remove = this.toRect().contains(player.toRect().bottomCenter) ||
          this.toRect().contains(player.toRect().bottomLeft) ||
          this.toRect().contains(player.toRect().bottomRight);
      if (remove) {
        destruir = true;
        player.score++;
      }
    }
  }

  @override
  bool destroy() {
    return destruir;
  }

  @override
  void resize(Size size) {
    var positionX = random.nextDouble();
    print(positionX);

    this.x = positionX * 300;
    this.y = 0;
  }
}
