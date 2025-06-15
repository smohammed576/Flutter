import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:race/dialogs/dialog.helper.dart';
import 'package:race/components/pylon.dart';
import 'package:race/screens/race.dart';
import 'package:race/components/star.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameReference<RaceScreen> {
  Player({required this.color})
    : super(size: Vector2(70, 120), position: Vector2(100, 500), priority: 10);

  final String color;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('car_$color.png', images: game.images);
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Star) {
      other.removeFromParent();
      game.stars++;
      game.hudState?.getStars(game.stars);
    } else if (other is Pylon) {
      game.pauseEngine();
      dialogBuilder(game.context, "Crashed!", color);
    } else {
      if (other.position.y > position.y - 475) {
        game.pauseEngine();
        dialogBuilder(game.context, "Finished!", color);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position.y -= 300 * dt;
    if (position.y <= 500) {
      position.y = size.y - (size.y - 500);
    }
    super.update(dt);
  }

  void moveLeft(double dt) {
    position.x += dt * 10;
    position.x = position.x.clamp(0, game.size.x - size.x);
  }

  void moveRight(double dt) {
    position.x += 200 * dt;
    if (position.x + size.x > game.size.x) {
      position.x = game.size.x - size.x;
    }
  }
}
