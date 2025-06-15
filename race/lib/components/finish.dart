import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:race/screens/race.dart';

class Finish extends SpriteComponent
    with CollisionCallbacks, HasGameReference<RaceScreen> {
  Finish(Vector2 position, Vector2 size)
    : super(size: Vector2(size.x, size.y), position: position, priority: 9);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('finish_track.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 400 * dt;
    if (position.y >= 1000) {
      position.y = -size.y;
    }
  }
}
