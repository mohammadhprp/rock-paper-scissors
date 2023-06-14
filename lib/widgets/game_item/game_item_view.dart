import 'package:flutter/material.dart';

import '../../models/game_interface/game_item_interface.dart';

class GameItemView extends StatelessWidget {
  final GameItemInterface gameInterface;

  const GameItemView({
    super.key,
    required this.gameInterface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: gameInterface.color,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gameInterface.icon,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            gameInterface.name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: gameInterface.color,
                ),
          ),
        ],
      ),
    );
  }
}
