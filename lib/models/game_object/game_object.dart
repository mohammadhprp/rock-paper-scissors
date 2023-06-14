import '../game_interface/game_item_interface.dart';
import '../game_item/paper.dart';
import '../game_item/rock.dart';
import '../game_item/scissors.dart';

class GameObject {
  double x;
  double y;
  double speedX;
  double speedY;
  double size;
  double screenWidth;
  double screenHeight;
  GameItemInterface gameInterface;

  GameObject({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.size,
    required this.screenWidth,
    required this.screenHeight,
    required this.gameInterface,
  });

  GameObject copyWith({required double x, required double y}) {
    return GameObject(
      x: x,
      y: y,
      speedX: speedX,
      speedY: speedY,
      size: size,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      gameInterface: gameInterface,
    );
  }

  bool isColliding(GameObject other) {
    return x < other.x + other.size &&
        x + size > other.x &&
        y < other.y + other.size &&
        y + size > other.y;
  }

  void handleCollision(
      GameObject other, Function(GameObject) removeObjectCallback) {
    if (gameInterface.name == other.gameInterface.name) {
      // Objects of the same type, make them bounce off each other
      double tempSpeedX = speedX;
      double tempSpeedY = speedY;
      speedX = other.speedX;
      speedY = other.speedY;
      other.speedX = tempSpeedX;
      other.speedY = tempSpeedY;
    } else {
      // Objects of different types, determine the winner and remove the losing object
      if (gameInterface is Rock && other.gameInterface is Scissors ||
          gameInterface is Scissors && other.gameInterface is Paper ||
          gameInterface is Paper && other.gameInterface is Rock) {
        // this object wins
        removeObjectCallback(other);
      } else {
        // other object wins
        removeObjectCallback(this);
      }
    }
  }

  void removeFromScreen() {
    // Reset the object's position outside the screen to remove it visually
    x = -size;
    y = -size;
  }
}
