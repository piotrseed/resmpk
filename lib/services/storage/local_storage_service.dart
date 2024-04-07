import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resmpk/helpers/app_constants.dart';
import 'package:resmpk/services/storage/boxes/like_storage.dart';

class LocalStorageService {
  final boxLikes = AppConstants.likes;

  Box<LikeStorage>? _likeBox;

  Future<LocalStorageService> init() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
      Hive.registerAdapter(LikeStorageAdapter());
      _likeBox = await Hive.openBox<LikeStorage>(boxLikes);
      return this;
    } catch (e) {
      log('Error initializing Hive: $e');
      return this;
    }
  }

  Future<String?> getLikes({required String likeId}) async {
    try {
      final sessions = _likeBox?.values.where((data) => data.likeId == likeId);
      if (sessions != null && sessions.isNotEmpty) {
        return sessions.first.likeId;
      }
    } catch (e) {
      log('Error getLikes: $e');
    }
    return null;
  }

  Future<void> saveLike({required String likeId}) async {
    try {
      final add = LikeStorage(likeId: likeId);
      await _likeBox?.put(likeId, add);
      log('saveLike: ${_likeBox?.values.map((e) => '${e.likeId}').toList()}');
    } catch (e) {
      log('Error saveLike: $e');
    }
  }
}
