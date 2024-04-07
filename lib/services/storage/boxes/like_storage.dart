import 'package:hive/hive.dart';

part 'like_storage.g.dart';

@HiveType(typeId: 0)
class LikeStorage {
  @HiveField(0)
  String? likeId;

  LikeStorage({
    this.likeId,
  });
}
