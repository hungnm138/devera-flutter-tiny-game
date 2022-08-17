import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game/game.dart';
import '../packages/audio_player.dart';
import '../packages/enemy_generator.dart';
import '../screens/main_menu.dart';

Widget gameOver(BuildContext context, TinyGame gameRef) {
  return Material(
    color: Colors.transparent,
    child: Center(
      child: Card(
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.all(gameRef.size.y - gameRef.size.y * 90 / 100),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Game Over",
              style: TextStyle(
                fontSize: gameRef.size.y - gameRef.size.y * 92 / 100,
                fontFamily: "Audiowide",
                color: Colors.white,
              ),
            ),
            SizedBox(height: gameRef.size.y - gameRef.size.y * 99 / 100),
            Text(
              "Your Score is",
              style: TextStyle(
                fontSize: gameRef.size.y - gameRef.size.y * 95 / 100,
                fontFamily: "Audiowide",
                color: Colors.white,
              ),
            ),
            SizedBox(height: gameRef.size.y - gameRef.size.y * 95 / 100),
            Text(
              gameRef.score.toStringAsFixed(0),
              style: TextStyle(
                fontSize: gameRef.size.y - gameRef.size.y * 90 / 100,
                fontFamily: "Audiowide",
                color: Colors.yellow,
              ),
            ),
            SizedBox(height: gameRef.size.y - gameRef.size.y * 97 / 100),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                AudioSfx.click.resume();
                gameRef.overlays.remove('Game Over');

                TinyGame.player.resume();
                gameRef.enemyGenerator.resetTimer();
                EnemyGenerator.spawnLevel = 0;
                gameRef.enemyGenerator.removeAllEnemy();
                gameRef.score = 0;
                gameRef.owlet.life.value = 3;
                gameRef.addAll([gameRef.scoreTitle, gameRef.scoreComponent]);
                gameRef.currentSpeed = 0.2;
                gameRef.parallaxComponent.parallax?.baseVelocity =
                    Vector2(gameRef.currentSpeed, 0);

                gameRef.resumeEngine();
              },
              child: Text(
                "Retry",
                style: TextStyle(
                  fontSize: gameRef.size.y - gameRef.size.y * 95 / 100,
                  fontFamily: "Audiowide",
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: gameRef.size.y - gameRef.size.y * 98 / 100),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                AudioSfx.click.resume();
                MainMenu.player.play('menu.mp3');
                TinyGame.player.stop();
                Navigator.pop(context);
              },
              child: Text(
                "Main Menu",
                style: TextStyle(
                  fontSize: gameRef.size.y - gameRef.size.y * 95 / 100,
                  fontFamily: "Audiowide",
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
      ),
    ),
  );
}
