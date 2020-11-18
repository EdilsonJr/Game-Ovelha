import 'package:flame/components/component.dart';
import 'package:flutter/material.dart';

const ComponentSize = 80.0;

class Ovelha extends SpriteComponent {
  double position = 0.0;
  bool gameover = false;
  Ovelha() : super.square(ComponentSize, 'ovelha.png');
  int score = 0;

  @override
  void update(double t) {
    super.update(t);
    this.x = position - (ComponentSize / 2) ;
    print(score);
    print(gameover);
  }

  @override
  bool destroy() {
    return false;
  }

  @override
  void resize(Size size) {
    this.x = size.width / 2 - (ComponentSize / 2);
    this.y = size.height / 2;
  }
}
