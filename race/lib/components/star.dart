import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Star extends SpriteComponent with CollisionCallbacks {
  Star(Vector2 position) : super(size: Vector2(50, 50), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('star.png');
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
