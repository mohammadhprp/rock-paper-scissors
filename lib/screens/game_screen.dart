import 'package:flutter/material.dart';

import '../models/game_item/paper.dart';
import '../models/game_item/rock.dart';
import '../models/game_item/scissors.dart';
import '../widgets/game_board/game_board.dart';
import '../widgets/game_item/game_item_view.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Paper Scissors'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GameItemView(
                gameInterface: Rock(),
              ),
              GameItemView(
                gameInterface: Paper(),
              ),
              GameItemView(
                gameInterface: Scissors(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(indent: 20, endIndent: 20),
          const GameBoard()
        ],
      ),
    );
  }
}
