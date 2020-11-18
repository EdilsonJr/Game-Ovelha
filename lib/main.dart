import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_base/componets/Background.dart';
import 'package:game_base/componets/Ovelha.dart';
import 'package:flame/anchor.dart';
import 'package:flame/text_config.dart';
import 'package:flame/components/text_component.dart';

import 'componets/Lobo.dart';
import 'componets/Moeda.dart';
import 'package:flame/gestures.dart';

var game;
BuildContext buildContext;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.images
      .loadAll(['moeda.png', 'lobo.png', 'ovelha.png', 'back.png']);
  var dimensions = await Flame.util.initialDimensions();
  game = JogoBase(dimensions);

  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ovelha',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return game.widget;
  }
}
class GameOverScreen extends StatelessWidget {
  final Ovelha ovelha;

  GameOverScreen(this.ovelha);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child:Text("Score: ${ovelha.score}", style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w800
            ),)),
            RaisedButton(
              child: Center(child:Text('Reiniciar',style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w800
              ),),),
              onPressed: () {
                ovelha.score = 0;
                ovelha.gameover = false;

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen(),
                    ));
              },)

          ],
        )
    );
  }
}

Moeda moeda;
Lobo lobo;
bool isOvelha = false;
List<Lobo> loboList;
BackgroundGame background;
TextComponent textScore;


class JogoBase extends BaseGame with TapDetector {
  Size dimensions;
  Ovelha ovelha;

  JogoBase(this.dimensions) {
    background = new BackgroundGame(this.dimensions);
    add(background);
    ovelha = new Ovelha();
    textScore = TextComponent('Score: ${ovelha.score}', config: TextConfig(color: Colors.black))
      ..anchor = Anchor.topCenter
      ..x = 50
      ..y = 32.0;

    add(textScore);
    loboList = <Lobo>[];
  }

  double creationTimer = 0.0;
  bool isLobo = false;
  @override
  void update(double t) {
    if (!isOvelha) {
      add(ovelha);
      isOvelha = true;
    }

    creationTimer += t;
    if (creationTimer >= 5) {
      creationTimer = 0.0;

      if (isLobo) {
        isLobo = false;
        moeda = new Moeda(dimensions,ovelha);
        add(moeda);
      } else {
        lobo = new Lobo(dimensions,ovelha);
        loboList.add(lobo);
        add(lobo);
        isLobo = true;
      }
    }
    textScore.text = 'Score: ${ovelha.score}';
    super.update(t);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTapDown(TapDownDetails details) {
    //print(
       // "Tap down on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
    if(!ovelha.gameover){
      ovelha.position = details.globalPosition.dx;
    }
  }

  @override
  void onTapUp(TapUpDetails details) {
    //print(
      //  "Tap up on ${details.globalPosition.dx} - ${details.globalPosition.dy}");
  }

}
