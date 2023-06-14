import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants/extensions/media_query_extension.dart';
import '../../models/game_item/paper.dart';
import '../../models/game_item/rock.dart';
import '../../models/game_item/scissors.dart';
import '../../models/game_object/game_object.dart';
import '../game_item/game_item_view.dart';

class GameBoard extends HookWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameObjects = useState<List<GameObject>>([]);
    final gameItems = [Rock(), Paper(), Scissors()];
    final random = useMemoized(() => Random());
    final width = context.width * 0.8;
    final height = context.height * 0.6;

    // This function iterates through the gameObjects list and checks for collisions between objects.
    void handleCollisions() {
      for (int i = 0; i < gameObjects.value.length; i++) {
        for (int j = i + 1; j < gameObjects.value.length; j++) {
          if (gameObjects.value[i].isColliding(gameObjects.value[j])) {
            gameObjects.value[i].handleCollision(
              gameObjects.value[j],
              (objectToRemove) => gameObjects.value.removeWhere(
                (obj) => obj == objectToRemove,
              ),
            );
          }
        }
      }
    }

    useEffect(() {
      // Initialize gameObjects
      for (int i = 0; i < 5; i++) {
        for (var game in gameItems) {
          gameObjects.value = [
            ...gameObjects.value,
            GameObject(
              x: random.nextDouble() * width,
              y: random.nextDouble() * height,
              speedX: (random.nextDouble() - 0.5) * 5,
              speedY: (random.nextDouble() - 0.5) * 5,
              size: 50,
              screenWidth: width,
              screenHeight: height,
              gameInterface: game,
            ),
          ];
        }
      }

      Timer.periodic(const Duration(milliseconds: 25), (timer) {
        final newGameObjects = <GameObject>[];

        // Update positions of gameObjects
        for (final gameObject in gameObjects.value) {
          final newX = gameObject.x + gameObject.speedX;
          final newY = gameObject.y + gameObject.speedY;

          if (newX < 0 || newX > width) {
            gameObject.speedX *= -1;
          }

          if (newY < 0 || newY > height) {
            gameObject.speedY *= -1;
          }

          newGameObjects.add(gameObject.copyWith(x: newX, y: newY));
        }
        // Update gameObjects
        gameObjects.value = newGameObjects;

        // Handle collisions between gameObjects
        handleCollisions();
      });
      return null;
    }, []);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Stack(
              children: gameObjects.value
                  .map((gameObject) => Positioned(
                        left: gameObject.x,
                        top: gameObject.y,
                        child: GameItemView(
                          gameInterface: gameObject.gameInterface,
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
