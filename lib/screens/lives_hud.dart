import 'package:flutter/material.dart';

import '../game/game.dart';
import '../packages/audio_player.dart';

Widget livesHud(TinyGame gameRef) {
  return ValueListenableBuilder(
    valueListenable: gameRef.owlet.life,
    builder: (BuildContext context, int value, Widget? child) {
      List<Widget> list = [];
      if (value <= 0) {
        // FlameAudio.play('death.mp3', volume: 70);
        AudioSfx.death.resume();
      }
      for (int i = 0; i < 5; i++) {
        list.add(Icon(
          Icons.favorite,
          color: i < value ? Colors.red : Colors.black,
          size: gameRef.size.y / 10,
        ));
      }
      return Padding(
        padding: EdgeInsets.only(
          top: gameRef.size.y - gameRef.size.y * 88 / 100,
          right: gameRef.size.x - gameRef.size.x * 95 / 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: list,
        ),
      );
    },
  );
}
