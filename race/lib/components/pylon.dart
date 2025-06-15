import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Pylon extends SpriteComponent with CollisionCallbacks {
  Pylon(Vector2 position) : super(size: Vector2(50, 50), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('pylon.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 400 * dt;
    if (position.y > 1000) {
      removeFromParent();
    }
  }
}
